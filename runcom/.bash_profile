# If not running interactively, don't do anything

[ -z "$PS1" ] && return

# Resolve DOTFILES_DIR (assuming ~/.dotfiles on distros without readlink and/or $BASH_SOURCE/$0)
CURRENT_SCRIPT=$BASH_SOURCE

if [[ -n $CURRENT_SCRIPT && -x readlink ]]; then
  SCRIPT_PATH=$(readlink -n $CURRENT_SCRIPT)
  DOTFILES_DIR="${PWD}/$(dirname $(dirname $SCRIPT_PATH))"
elif [ -d "$HOME/.dotfiles" ]; then
  DOTFILES_DIR="$HOME/.dotfiles"
else
  echo "Unable to find dotfiles, exiting."
  return
fi

# Make utilities available

PATH="$DOTFILES_DIR/bin:/opt/homebrew/sbin:$PATH"

# Source the dotfiles (order matters)

for DOTFILE in "$DOTFILES_DIR"/system/.{function,function_*,path,env,exports,alias,fnm,grep,prompt,completion,fix}; do
  [ -f "$DOTFILE" ] && . "$DOTFILE"
done

if is-macos; then
  for DOTFILE in "$DOTFILES_DIR"/system/.{env,alias,function,path}.macos; do
    [ -f "$DOTFILE" ] && . "$DOTFILE"
  done
fi

# Set LSCOLORS

eval "$(dircolors -b "$DOTFILES_DIR"/system/.dir_colors)"

# Clean up

unset CURRENT_SCRIPT SCRIPT_PATH DOTFILE

# Export

export DOTFILES_DIR

eval "$(thefuck --alias)"

# pnpm
export PNPM_HOME="/Users/martin/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm endexport

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/martin/google-cloud-sdk/path.bash.inc' ]; then . '/Users/martin/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/martin/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/martin/google-cloud-sdk/completion.bash.inc'; fi

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[ -f /Users/martin/.config/.dart-cli-completion/bash-config.bash ] && . /Users/martin/.config/.dart-cli-completion/bash-config.bash || true
## [/Completion]


# Added by Windsurf
export PATH="/Users/martin/.codeium/windsurf/bin:$PATH"
