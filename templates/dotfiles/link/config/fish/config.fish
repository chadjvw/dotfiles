{% for file in manual_programs.files %}
set fish_user_paths $fish_user_paths {{ file.path }}
{% endfor %}
set fish_user_paths $fish_user_paths /home/{{ username }}/.dotfiles/source
set fish_user_paths $fish_user_paths /home/{{ username }}/.local/bin
set fish_user_paths $fish_user_paths /home/{{ username }}/programs/pcicloud

set -Ux DOCKER_HOST localhost:2375
set -Ux JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre
set -Ux DISPLAY 127.0.0.1:0.0
set -Ux GDK_THEME Adapta-Nokto-Eta
set -Ux QT_STYLE_OVERRIDE Adapta-Nokto-Eta
set -gx EDITOR nvim
set -Ux AWS_EC2_METADATA_DISABLED 1

test -x (which aws_completer); and complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

alias vi="nvim"
alias vim="nvim"
alias svim="sudo nvim"
alias svi="sudo nvim"
alias edit="nvim"

alias clean-branches='git branch | grep -ve "master\$" | xargs git branch -D'

alias ls="ls --color=auto"
alias la="ls -alhF --color=auto"
alias grep="grep --color=auto"
alias rg="rg -S"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias mkdir="mkdir -pv"
alias mv="mv -v"
alias rm="rm -vi"
alias cp="cp -v"

alias update="sudo apt update; sudo apt upgrade -y"
alias df="df -H"
alias du="du -ch"
alias top="htop"
alias df="pydf"

alias netstat="sudo netstat -tulpn"

alias sudo="sudo "
alias ping="ping -c 5"
alias cloud="ssh cvanwyhe@cloud.powercosts.com"
alias untar="tar -xvf"