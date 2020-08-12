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
set PATH {{ file.path }} $PATH
{% endfor %}
# TODO: check if path exists
# TODO: install dein if it doesnt exist and call installer
# install cargo and crates?
set PATH {{ user_home }}/.dotfiles/source $PATH
set PATH {{ user_home }}/.local/bin $PATH
set PATH {{ user_home }}/.cargo/bin $PATH
set PATH {{ user_home }}/.toolbox/bin $PATH

# Override fish colors
set fish_color_normal white
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

set -Ux EDITOR nvim
set -Ux AWS_EC2_METADATA_DISABLED 1
set -Ux XDG_DATA_DIRS "/usr/local/share:/usr/share"
set -Ux XDG_DATA_HOME "$HOME/.local/share"
set -Ux XDG_CONFIG_HOME "$HOME/.config"
set -Ux FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,*.swp,dist}/*" 2> /dev/null'
set -Ux FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

{% if ansible_distribution == 'MacOSX'%}
# jhome -v 1.8    #switches to java 1.8
# jhome -v 11    #switches to java 11
function jhome
    set JAVA_HOME (/usr/libexec/java_home $argv)
    echo "JAVA_HOME:" $JAVA_HOME
    echo "java -version:"
    java -version
end

# Add GRC: https://github.com/garabik/grc
source /usr/local/etc/grc.fish
{% else %}
set -Ux SXHKD_SHELL /bin/bash
set -Ux JAVA_HOME /usr/lib/jvm/java-8-openjdk

# Add GRC: https://github.com/garabik/grc
source /etc/grc.fish
{% endif %}

test -x (which aws_completer); and complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

source ~/.alias

if test -e ~/.internal-alias
    source ~/.internal-alias
end

# macos doesnt like sourcing this alias
alias ls="exa --icons"

# init for pyenv
status --is-interactive; and source (pyenv init -|psub)

starship init fish | source
zoxide init fish | source
