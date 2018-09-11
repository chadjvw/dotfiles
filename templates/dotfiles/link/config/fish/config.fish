{% for file in manual_programs.files %}
set fish_user_paths $fish_user_paths {{ file.path }}
{% endfor %}
set fish_user_paths $fish_user_paths /home/{{ username }}/source
set fish_user_paths $fish_user_paths /home/{{ username }}/.local/bin
set fish_user_paths $fish_user_paths /home/{{ username }}/programs/pcicloud
set -Ux JAVA_HOME (which java)
set -Ux DISPLAY 127.0.0.1:0.0
set -Ux GDK_THEME Adapta-Nokto-Eta
set -Ux QT_STYLE_OVERRIDE Adapta-Nokto-Eta

alias vi="nvim"
alias vim="nvim"
alias svim="sudo nvim"
alias svi="sudo nvim"
alias edit="nvim"

alias la="ls -alhF"
alias ..="cd .."
alias ...="cd ../.."

alias mkdir="mkdir -pv"
alias mv="mv -v"
alias rm="rm -vi"
alias cp="cp -v"

alias update="sudo apt update; sudo apt upgrade -y"

## set some other defaults ##
alias df="df -H"
alias du="du -ch"

# top is atop, just like vi is vim
alias top="htop"

alias netstat="sudo netstat -tulpn"

alias sudo="sudo "
alias ping="ping -c 5"
alias cloud="ssh {{ work_username }}@cloud.powercosts.com"
alias untar="tar -xvf"