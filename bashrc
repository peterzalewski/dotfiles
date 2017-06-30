if [[ -n "${DISPLAY}" && "${TERM}" == "xterm" ]]; then
  export TERM="xterm-256color"
fi

alias got='git '
alias get='git '
alias grep='grep --color=auto'
alias shit='sudo $(fc -ln -1)'
alias mux='tmuxinator'

export EDITOR="vim"
export PAGER="less"

# Better history courtesy of https://sanctum.geek.nz/arabesque/better-bash-history/

shopt -s histappend                   # Shells append to history rather than overwrite
HISTFILESIZE=1000000                  # Let's keep lots of history
HISTSIZE=1000000                      # "
HISTCONTROL=ignoreboth                # Do not log duplicate commands or those that start with a space
HISTIGNORE='ls:bg:fg:history:clear'   # Ignore common drudgery
HISTTIMEFORMAT='%F %T '               # Use a sensible timestamp
shopt -s cmdhist                      # Append to history immediately, rather than on exit

readonly OS=$(uname)

case "${OS}" in
  Darwin) alias ls="ls -hG" ;;
  *) alias ls="ls --group-directories-first --color -h" ;;
esac

[[ -f /usr/local/etc/bash_completion.d/git-prompt.sh ]] && . /usr/local/etc/bash_completion.d/git-prompt.sh

# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# Underline
UBlack="\[\033[4;30m\]"       # Black
URed="\[\033[4;31m\]"         # Red
UGreen="\[\033[4;32m\]"       # Green
UYellow="\[\033[4;33m\]"      # Yellow
UBlue="\[\033[4;34m\]"        # Blue
UPurple="\[\033[4;35m\]"      # Purple
UCyan="\[\033[4;36m\]"        # Cyan
UWhite="\[\033[4;37m\]"       # White

# Background
On_Black="\[\033[40m\]"       # Black
On_Red="\[\033[41m\]"         # Red
On_Green="\[\033[42m\]"       # Green
On_Yellow="\[\033[43m\]"      # Yellow
On_Blue="\[\033[44m\]"        # Blue
On_Purple="\[\033[45m\]"      # Purple
On_Cyan="\[\033[46m\]"        # Cyan
On_White="\[\033[47m\]"       # White

# High Intensty
IBlack="\[\033[0;90m\]"       # Black
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green
IYellow="\[\033[0;93m\]"      # Yellow
IBlue="\[\033[0;94m\]"        # Blue
IPurple="\[\033[0;95m\]"      # Purple
ICyan="\[\033[0;96m\]"        # Cyan
IWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
BIBlack="\[\033[1;90m\]"      # Black
BIRed="\[\033[1;91m\]"        # Red
BIGreen="\[\033[1;92m\]"      # Green
BIYellow="\[\033[1;93m\]"     # Yellow
BIBlue="\[\033[1;94m\]"       # Blue
BIPurple="\[\033[1;95m\]"     # Purple
BICyan="\[\033[1;96m\]"       # Cyan
BIWhite="\[\033[1;97m\]"      # White

# High Intensty backgrounds
On_IBlack="\[\033[0;100m\]"   # Black
On_IRed="\[\033[0;101m\]"     # Red
On_IGreen="\[\033[0;102m\]"   # Green
On_IYellow="\[\033[0;103m\]"  # Yellow
On_IBlue="\[\033[0;104m\]"    # Blue
On_IPurple="\[\033[10;95m\]"  # Purple
On_ICyan="\[\033[0;106m\]"    # Cyan
On_IWhite="\[\033[0;107m\]"   # White

export PS1='['$BIWhite'\u'$Color_Off'@'$BIWhite'\h'$Color_Off'|'$BIWhite'\w'$Color_Off'$(git branch &>/dev/null;\
    if [ $? -eq 0 ]; then \
        echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
        if [ "$?" -eq "0" ]; then \
            echo "'$Green'"$(__git_ps1 " (%s)"); \
        else \
            echo "'$IRed'"$(__git_ps1 " {%s}"); \
        fi)'$Color_Off'"; \
    fi)]\$ '

export NVM_DIR="/home/peterz/.nvm"
[[ -s "${NVM_DIR}/nvm.sh" ]] && . "${NVM_DIR}/nvm.sh"  # This loads nvm

[[ -f ~/.bashrc.local ]] && . ~/.bashrc.local

[[ -s "${HOME}/.rvm/scripts/rvm" ]] && . "${HOME}/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[[ -f /usr/local/etc/profile.d/autojump.sh ]] && . /usr/local/etc/profile.d/autojump.sh
