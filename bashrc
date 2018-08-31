set -o vi

alias g='git'
alias got='git '
alias get='git '
alias gs='git st'
alias gb='git branch -vv'
alias gd='git d'
alias gc='git co'
alias gh5='git hist -5'
alias gh10='git hist -10'
alias grep='grep --color=auto'
alias t='txopen'
alias view='view -M'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

declare -a fun_words=(shit damnit fuck please)
for word in "${fun_words[@]}"; do
  alias "${word}"='sudo $(fc -ln -1)'
done
unset fun_words

export EDITOR="vim"
export VISUAL="vim"
export PAGER="less"
export LESS="-igMRFX"
export FZF_DEFAULT_COMMAND="rg --files -L"
export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"

# Better history courtesy of https://sanctum.geek.nz/arabesque/better-bash-history/

shopt -s histappend                   # Shells append to history rather than overwrite
HISTFILESIZE=1000000                  # Let's keep lots of history
HISTSIZE=1000000                      # "
HISTCONTROL=ignoreboth                # Do not log duplicate commands or those that start with a space
HISTIGNORE='ls:bg:fg:history:clear'   # Ignore common drudgery
HISTTIMEFORMAT='%F %T '               # Use a sensible timestamp
shopt -s cmdhist                      # Append to history immediately, rather than on exit

case "$(uname)" in
  Darwin)
    alias ls="ls -hG"
    export LSCOLORS='ExFxcxdxBxegedabagacad'
    export LESS_TERMCAP_md=$'\e[01;34m'
    export LESS_TERMCAP_me=$'\e[0m'
    export LESS_TERMCAP_se=$'\e[0m'
    export LESS_TERMCAP_so=$'\e[01;45;37m'
    export LESS_TERMCAP_ue=$'\e[0m'
    export LESS_TERMCAP_us=$'\e[01;32m'
    ;;
  *)
    alias ls="ls --group-directories-first --color -h"
    ;;
esac

_try_load() {
  local -r file="${1:-}"
  [[ -s "${file}" ]] && . "${file}"
}

_try_load /usr/local/etc/bash_completion.d/git-prompt.sh
_try_load /usr/local/etc/profile.d/autojump.sh
_try_load "${HOME}/.load_virtualenvwrapper.sh"

for config_file in "${HOME}"/.bash.d/*; do
  _try_load "${config_file}"
done

unset _try_load

vimc() {
  [[ "$#" == 1 ]] && vim $(command -v "$1")
}

# TODO(pzalewski): Switch to manual escape sequences for speed?
declare PROMPT_BG_COLOR="$(tput bold)"
declare PROMPT_COLOR_OFF="$(tput sgr0)"
declare PROMPT_DIR_COLOR="$(tput bold)$(tput setaf 4)"
declare PROMPT_HOST_COLOR="$(tput bold)$(tput setaf 1)"
declare PROMPT_RCS_COLOR="$(tput bold)$(tput setaf 5)"
# TODO(pzalewski): Does this work <bash 4.2?
declare PROMPT_SYMBOL=$'\u276F\u276F'
declare PROMPT_SYMBOL_COLOR="$(tput bold)$(tput setaf 7)"
declare PROMPT_USER_COLOR="$(tput bold)$(tput setaf 2)"

# TODO(pzalewski): Check for __git_ps1 before referencing
export PS1="\
\[${PROMPT_USER_COLOR}\]\u\[${PROMPT_COLOR_OFF}\] \
\[${PROMPT_BG_COLOR}\]at\[${PROMPT_COLOR_OFF}\] \
\[${PROMPT_HOST_COLOR}\]\h\[${PROMPT_COLOR_OFF}\] \
\[${PROMPT_BG_COLOR}\]in\[${PROMPT_COLOR_OFF}\] \
\[${PROMPT_DIR_COLOR}\]\w\[${PROMPT_COLOR_OFF}\]\
\$(__git_ps1 ' \[${PROMPT_BG_COLOR}\]on\[${PROMPT_COLOR_OFF}\] \[${PROMPT_RCS_COLOR}\]%s\[${PROMPT_COLOR_OFF}\]')\
\[${PROMPT_SYMBOL_COLOR}\] \[${PROMPT_SYMBOL}\]\[${PROMPT_COLOR_OFF}\] "

unset PROMPT_BG_COLOR
unset PROMPT_COLOR_OFF
unset PROMPT_DIR_COLOR
unset PROMPT_HOST_COLOR
unset PROMPT_RCS_COLOR
unset PROMPT_SYMBOL
unset PROMPT_SYMBOL_COLOR
unset PROMPT_USER_COLOR
