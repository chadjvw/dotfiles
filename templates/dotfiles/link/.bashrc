# Where the magic happens.
export DOTFILES={{ dotfiles_home }}

# Source all files in "source"
for file in $DOTFILES/source/*; do
  source "$file"
done

source ~/.alias

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export EDITOR=nvim
export AWS_EC2_METADATA_DISABLED=1
export SXHKD_SHELL=/usr/bin/bash
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_DIRS=$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
