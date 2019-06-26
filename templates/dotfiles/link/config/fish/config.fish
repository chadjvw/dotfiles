#       ___                     ___           ___     
#      /  /\      ___          /  /\         /__/\    
#     /  /:/_    /  /\        /  /:/_        \  \:\   
#    /  /:/ /\  /  /:/       /  /:/ /\        \__\:\  
#   /  /:/ /:/ /__/::\      /  /:/ /::\   ___ /  /::\ 
#  /__/:/ /:/  \__\/\:\__  /__/:/ /:/\:\ /__/\  /:/\:\
#  \  \:\/:/      \  \:\/\ \  \:\/:/~/:/ \  \:\/:/__\/
#   \  \::/        \__\::/  \  \::/ /:/   \  \::/     
#    \  \:\        /__/:/    \__\/ /:/     \  \:\     
#     \  \:\       \__\/       /__/:/       \  \:\    
#      \__\/                   \__\/         \__\/    

{% for file in manual_programs.files %}
set fish_user_paths $fish_user_paths {{ file.path }}
{% endfor %}
set fish_user_paths $fish_user_paths /home/{{ username }}/.dotfiles/source
set fish_user_paths $fish_user_paths /home/{{ username }}/.local/bin
set fish_user_paths $fish_user_paths /home/{{ username }}/programs/pcicloud
set fish_user_paths $fish_user_paths /home/{{ username }}/.cargo/bin

# Override fish colors
set fish_color_normal normal
set fish_color_quote bryellow
set fish_color_autosuggestion brblack
set fish_color_command brwhite
set fish_color_comment yellow
set fish_color_end brwhite
set fish_color_error brred
set fish_color_cancel brred
set fish_color_operator green
set fish_color_param cyan
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

set -Ux JAVA_HOME /usr/lib/jvm/java-8-openjdk
set -Ux EDITOR nvim
set -Ux AWS_EC2_METADATA_DISABLED 1
set -Ux SXHKD_SHELL /bin/bash
set -Ux XDG_DATA_HOME "$HOME/.local/share"
set -Ux XDG_CONFIG_HOME "$HOME/.config"
set -Ux XDG_DATA_DIRS "$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share"

test -x (which aws_completer); and complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

source ~/.alias
