{% for file in manual_programs.files %}
set fish_user_paths $fish_user_paths {{ file.path }}
{% endfor %}
set fish_user_paths $fish_user_paths /home/{{ username }}/.dotfiles/source
set fish_user_paths $fish_user_paths /home/{{ username }}/.local/bin
set fish_user_paths $fish_user_paths /home/{{ username }}/programs/pcicloud
set fish_user_paths $fish_user_paths /home/{{ username }}/.cargo/env

# Override fish colors
set fish_color_normal normal
set fish_color_quote bryellow
set fish_color_autosuggestion brblack
set fish_color_command cyan
set fish_color_comment yellow
set fish_color_end brwhite
set fish_color_error brred
set fish_color_cancel brred
set fish_color_operator green
set fish_color_param brwhite
set fish_color_escape red
set fish_color_redirection magenta
set fish_color_cwd magenta
set fish_pager_color_progress brwhite --background=blue
set fish_pager_color_completion blue
set fish_pager_color_description yellow
set fish_color_match brwhite --background=brmagenta
set fish_color_history_current brgreen

# Colored man pages
set -g man_blink -o red
set -g man_bold -o green
set -g man_standout red
set -g man_underline -u yellow

set -Ux JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
set -Ux EDITOR nvim
set -Ux AWS_EC2_METADATA_DISABLED 1
set -U SXHKD_SHELL /bin/bash
set -U XDG_DATA_HOME "$HOME/.local/share"
set -U XDG_CONFIG_HOME "$HOME/.config"
set -U XDG_DATA_DIRS "$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share"

test -x (which aws_completer); and complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

alias vi="nvim"
alias vim="nvim"
alias svim="sudo nvim"
alias svi="sudo nvim"
alias edit="nvim"

alias ydt="yarn deploy --stage test --aws-profile tf --verbose"
alias ydd="yarn deploy --stage dev --aws-profile ius-dev --verbose"

alias clean-branches='git branch | grep -ve "master\$" | xargs git branch -D'

alias ls="ls --color=auto"
alias la="ls -alhF --color=auto"
alias grep="grep --color=auto"
alias rg="rg -S"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias mkdir="mkdir -pv"
alias mv="mv -v"
alias rm="rm -vi"
alias cp="cp -v"

alias update="sudo apt update; sudo apt upgrade -y; flatpak update -y"
alias df="df -H"
alias du="du -ch"
alias top="gotop"
alias df="pydf"

alias netstat="sudo netstat -tulpn"

alias sudo="sudo "
alias ping="ping -c 5"
alias untar="tar -xvf"