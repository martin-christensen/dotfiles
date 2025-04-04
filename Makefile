SHELL = /bin/bash
OS := $(shell bin/is-supported bin/is-macos macos linux)
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
HOMEBREW_PREFIX := $(shell bin/is-supported bin/is-arm64 /opt/homebrew /usr/local)
PATH := $(HOMEBREW_PREFIX)/bin:$(DOTFILES_DIR)/bin:$(PATH)
export XDG_CONFIG_HOME = $(HOME)/.config
export STOW_DIR = $(DOTFILES_DIR)
export ACCEPT_EULA=Y

.PHONY: test

all: $(OS)

macos: sudo core-macos packages link

linux: core-linux link

core-macos: brew bash git npm ruby rust

core-linux:
	apt-get update
	apt-get upgrade -y
	apt-get dist-upgrade -f

stow-macos: brew
	is-executable stow || brew install stow

stow-linux: core-linux
	is-executable stow || apt-get -y install stow

sudo:
ifndef GITHUB_ACTION
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
endif

packages: brew-packages cask-apps macos-apps remote-dmg node-packages rust-packages composer-packages

link: stow-$(OS)
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then \
		mv -v $(HOME)/$$FILE{,.bak}; fi; done
	mkdir -p $(XDG_CONFIG_HOME)
	stow -t $(HOME) runcom
	stow -t $(XDG_CONFIG_HOME) config

unlink: stow-$(OS)
	stow --delete -t $(HOME) runcom
	stow --delete -t $(XDG_CONFIG_HOME) config
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE.bak ]; then \
		mv -v $(HOME)/$$FILE.bak $(HOME)/$${FILE%%.bak}; fi; done

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash

bash: BASH_BIN=$(HOMEBREW_PREFIX)/bin/bash
bash: BREW_BIN=$(HOMEBREW_PREFIX)/bin/brew
bash: SHELLS=/private/etc/shells
bash: brew
ifdef GITHUB_ACTION
	if ! grep -q $(BASH_BIN) $(SHELLS); then \
		$(BREW_BIN) install bash bash-completion@2 pcre && \
		sudo append $(BASH_BIN) $(SHELLS) && \
		sudo chsh -s $(BASH_BIN); \
	fi
else
	if ! grep -q $(BASH_BIN) $(SHELLS); then \
		$(BREW_BIN) install bash bash-completion@2 pcre && \
		sudo append $(BASH_BIN) $(SHELLS) && \
		chsh -s $(BASH_BIN); \
	fi
endif

git: brew
	brew install git git-extras

npm: brew-packages
	fnm install --lts

ruby: brew
	brew install ruby

rust: brew
	brew install rust

composer: brew
	is-executable composer || brew install composer

brew-packages: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile || true

cask-apps: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile || true
	defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
	echo "Installing VS Codium extensions from open-vsx.org..."
	for EXT in $$(cat install/Codefile); do windsurf --install-extension $$EXT --force; done
	echo "Installing VS Codium extensions from source..."
	for EXT in $$(ls install/vscode/extensions); do windsurf --install-extension install/vscode/extensions/$$EXT --force; done
	xattr -d -r com.apple.quarantine ~/Library/QuickLook

macos-apps: brew
	is-executable mas || brew install mas
	while read -r APP; do APP=$$(sed 's/#.*//' <<< $$APP); mas install $$APP; done < install/masfile

remote-dmg:
	is-executable install-dmg
	while read -r DMG; do DMG=$$(sed 's/#.*//' <<< $$DMG); if [[ ! -z "$$DMG" ]]; then install-dmg $$DMG; fi; done < install/remotedmgfile

node-packages: npm
	eval $$(fnm env); npm install -g $(shell cat install/npmfile)

rust-packages: rust
	cargo install $(shell cat install/Rustfile)

composer-packages: composer
	composer global require $(shell cat install/composerfile)

test:
	eval $$(fnm env); bats test
