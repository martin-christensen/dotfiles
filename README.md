# .files

These are my dotfiles. Take anything you want, but at your own risk.

It mainly targets macOS systems, but it works on at least Ubuntu as well.

## Highlights

- Minimal efforts to install everything, using a [Makefile](./Makefile)
- Mostly based around Homebrew, Caskroom and Node.js, latest Bash + GNU Utils
- Great [Window management](./config/hammerspoon/README.md) (using Hammerspoon)
- Fast and colored prompt
- Updated macOS defaults
- Well-organized and easy to customize
- The installation and runcom setup is [tested weekly on real Ubuntu and macOS
  machines](https://github.com/martin-christensen/dotfiles/actions) (Big Sur and Monterey;
  Catalina should still be fine too) using [a GitHub
  Action](./.github/workflows/ci.yml)
- Supports both Apple Silicon (M1) and Intel chips

## Package Overview

- [Homebrew](https://brew.sh) (packages: [Brewfile](./install/Brewfile))
- [homebrew-cask](https://github.com/Homebrew/homebrew-cask) (packages: [Caskfile](./install/Caskfile))
- [Node.js + npm LTS](https://nodejs.org/en/download/) (packages: [npmfile](./install/npmfile))
- Latest Git, Bash 4, Python 3, GNU coreutils, curl, Ruby
- [Hammerspoon](https://www.hammerspoon.org) (config: [keybindings & window management](./config/hammerspoon))
- [Mackup](https://github.com/lra/mackup) (sync application settings)
- `$EDITOR` (and Git editor) is [GNU nano](https://www.nano-editor.org)

## Installation

On a sparkling fresh installation of macOS:

```bash
sudo softwareupdate -i -a --install-rosetta
xcode-select --install
```

The Xcode Command Line Tools includes `git` and `make` (not available on stock macOS). Now there are two options:

1. Install this repo with `curl` available:

```bash
bash -c "`curl -fsSL 
https://raw.githubusercontent.com/martin-christensen/dotfiles/master/remote-install.sh`"
```

This will clone or download, this repo to `~/.dotfiles` depending on the availability of `git`, `curl` or `wget`.

1. Alternatively, clone manually into the desired location:

```bash
git clone git@github.com:martin-christensen/dotfiles.git ~/.dotfiles
```

Use the [Makefile](./Makefile) to install everything [listed above](#package-overview), and symlink [runcom](./runcom)
and [config](./config) (using [stow](https://www.gnu.org/software/stow/)):

```bash
cd ~/.dotfiles
make
```

The installation process in the Makefile is tested on every push and every week in this
[GitHub Action](https://github.com/martin-christensen/dotfiles/actions).

## Post-Installation

- `dot dock` (set [Dock items](./macos/dock.sh))
- `dot macos` (set [macOS defaults](./macos/defaults.sh))
- Dory
  - `ln -s ~/.dotfiles/config/dory/.dory.yml ~`
  - `ln -s ~/.dotfiles/config/dory/cert ~/.dory_cert`
  - `dory up`
  - `docker update --restart=always $CONTAINER_IDS` for the dory containers, so its ensured that they will start up on a machine restart
- Mackup
  - Log in to Dropbox (and wait until synced)
  - `ln -s ~/.config/mackup/.mackup.cfg ~` (until [#632](https://github.com/lra/mackup/pull/632) is fixed)
  - `mackup restore`
- Want to custimize the vscode terminal theme? Checkout [Base16 Terminal Colors Generator](https://glitchbone.github.io/vscode-base16-term/#/)

## The `dotfiles` command

```bash
$ dot help
Usage: dot <command>

Commands:
    clean            Clean up caches (brew, npm, gem, rvm)
    dock             Apply macOS Dock settings
    edit             Open dotfiles in IDE (codium) and Git GUI (stree)
    help             This help message
    macos            Apply macOS system defaults
    test             Run tests
    update           Alias for topgrade
```

## Customize

To customize the dotfiles to your likings, fork it and make sure to modify the locations above to your fork.

## Credits

Many thanks to the [dotfiles community](https://dotfiles.github.io).
