# vim: set foldmethod=marker foldlevel=0 nomodeline:
# ############################################################################
# Description: focus on start up speed, colors, and shortcuts. not too wild.
# Author: Peter Zalewski <peter@zalewski.com>
# Source: https://github.com/peterzalewski/dotfiles/blob/master/bashrc
# ############################################################################

# Aliases {{{

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias bc='bc --mathlib'
alias g='git'
alias gb='git branch -vv'
alias gc='git checkout'
alias gd='git d'
alias get='git'
alias gh='git hist'
alias gh5='git hist -5'
alias gh10='git hist -10'
alias got='git'
alias grep='grep --color=auto'
alias gs='git st'
alias map='xargs --max-args=1'
alias tpout='tput'
alias view='view -M'

# Let me swear at the command prompt to sudo the previous command
declare -a fun_words=(shit damnit fuck please)
for word in "${fun_words[@]}"; do
  # shellcheck disable=SC2139
  alias "${word}"='sudo $(fc -ln -1)'
done

# }}}
# Default programs and settings {{{

export EDITOR='vim'
export FZF_DEFAULT_COMMAND='rg --files -L'
export FZF_DEFAULT_OPTS='--color=16,hl:12,fg+:14,pointer:11,info:6 --reverse --inline-info --prompt="❯❯ "'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export LESS='-igMRFX'
export LESSHISTFILE='-'
export PAGER='less'
export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"
export VISUAL='vim'

# Use vi-like bindings instead of emacs-like bindings to edit
set -o vi

# Attempt to enable Bash 4 '**' recursive globbing
shopt -s globstar >/dev/null 2>&1

# }}}
# History {{{

# Better history courtesy of https://sanctum.geek.nz/arabesque/better-bash-history/
# Save multi-line commands as one command
shopt -s cmdhist

# Shells append to history rather than overwrite
shopt -s histappend

# Let's keep lots of history
export HISTFILESIZE=1000000

# Ditto
export HISTSIZE=1000000

# Do not log duplicate commands or those that start with a space
export HISTCONTROL='ignoreboth'

# Ignore common drudgery
export HISTIGNORE='ls:bg:fg:history:clear:jobs:exit'

# Use ISO8601 for history timestamps
export HISTTIMEFORMAT='%Y-%m-%dT%H:%M:%S%z '

# }}}
# Colors and appearance {{{

# Colorize ls/exa
if [[ -n "$(command -v exa)" ]]; then
  alias ls='exa'
  alias tree='exa -T'
else
  case "$(uname)" in
    Darwin) alias ls="ls -hG" ;;
    *) alias ls='ls --group-directories-first --color -h' ;;
  esac

  # Set custom colors for `ls`: bold blue for directories,
  # bold magenta for links, bold red for executables
  export LSCOLORS='ExFxcxdxBxegedabagacad'
fi

# `less` checks for LESS_TERMCAP_* environment variables before checking the
# termcap database for the corresponding control characters. `man` uses only
# bold, standout, and underline formatting, so if we override those control
# characters, we can add color to man pages. More at:
# https://unix.stackexchange.com/questions/108699/documentation-on-less-termcap-variables

# Set bold to bold + blue; used for headers
export LESS_TERMCAP_md="$(tput bold; tput setaf 4)"

# End bold
export LESS_TERMCAP_me="$(tput sgr0)"

# Set standout to bold + magenta background + white foreground; used for pager
export LESS_TERMCAP_so="$(tput bold ; tput setaf 7 ; tput setab 5)"

# End standout
export LESS_TERMCAP_se="$(tput sgr0)"

# Set underline to bold + green; used for keywords
export LESS_TERMCAP_us="$(tput bold ; tput setaf 2)"

# End underline
export LESS_TERMCAP_ue="$(tput sgr0)"

if [[ -n "$(command -v grc)" ]]; then
  alias colorify="grc -es --colour=auto"
  for app in {ps,du,df,lsof,ifconfig,ping,traceroute,dig}; do
    alias "${app}"="colorify "${app}""
  done
fi

# }}}
# Prompt {{{

# Create a prompt like this, with colors (escape sequences) set with the
# variables listed below:
#
# username at host in directory [on branch] $
# *        |  *       |             *       |
# |        |  |       |             |       +-> PROMPT_SYMBOL_COLOR
# |        |  |       |             +--------*> PROMPT_RCS_COLOR
# |        |  |       +-----------------------> PROMPT_DIR_COLOR
# |        |  +------------------------------*> PROMPT_HOST_COLOR
# |        +----------------------------------> PROMPT_SMALL_WORD_COLOR
# +------------------------------------------*> PROMPT_USER_COLOR

declare PROMPT_COLOR_OFF="$(tput sgr0)"

# Bold
declare PROMPT_SMALL_WORD_COLOR="$(tput bold)"

# Bold + blue
declare PROMPT_DIR_COLOR="$(tput bold ; tput setaf 4)"

# Bold + red
declare PROMPT_HOST_COLOR="$(tput bold ; tput setaf 1)"

# Bold + magenta
declare PROMPT_RCS_COLOR="$(tput bold ; tput setaf 5)"

# '❯'
declare PROMPT_SYMBOL=$'\xE2\x9D\xAF'

# Bold + white
declare PROMPT_SYMBOL_COLOR="$(tput bold ; tput setaf 7)"

# Bold + green
declare PROMPT_USER_COLOR="$(tput bold ; tput setaf 2)"

# Bold + red
declare PROMPT_LAST_COMMAND_FAILED="$(tput bold ; tput setaf 1)"

# Replace ~ in the current path with 🏠
function _prompt_pwd {
  declare -r PWD_WITHOUT_HOME="${PWD#$HOME}"
  if [[ "${PWD}" != "${PWD_WITHOUT_HOME}" ]]; then
    printf "🏠\001${PROMPT_DIR_COLOR}\002${PWD_WITHOUT_HOME}\001${PROMPT_COLOR_OFF}\002"
  else
    printf "\001${PROMPT_DIR_COLOR}\002${PWD}\001${PROMPT_COLOR_OFF}\002"
  fi
}

# Evaluate __git_ps1 if it is available
function _prompt_rcs_status {
  if [[ -n "$(type -t __git_ps1)" ]]; then
    printf "$(__git_ps1 " \001${PROMPT_SMALL_WORD_COLOR}\002on\001${PROMPT_COLOR_OFF}\002 \
\001${PROMPT_RCS_COLOR}\002%s\001${PROMPT_COLOR_OFF}\002")"
  else
    printf ""
  fi
}

# Display the prompt symbol in red if the last shell command failed
function _prompt_color_symbol_by_exit_status {
  if [[ "${LAST_EXIT}" != 0 ]]; then
    printf "\001${PROMPT_LAST_COMMAND_FAILED}\002${PROMPT_SYMBOL}\001${PROMPT_COLOR_OFF}\002"
  else
    printf "\001${PROMPT_SYMBOL_COLOR}\002${PROMPT_SYMBOL}\001${PROMPT_COLOR_OFF}\002"
  fi
}

# Save the exit code of the last shell command. This must happen
# before functions to build the prompt are called.
function _prompt_save_last_exit {
  export LAST_EXIT="$?"
}

export PROMPT_COMMAND="_prompt_save_last_exit"
export PS1="\
\[${PROMPT_USER_COLOR}\]\u\[${PROMPT_COLOR_OFF}\] \
\[${PROMPT_SMALL_WORD_COLOR}\]at\[${PROMPT_COLOR_OFF}\] \
\[${PROMPT_HOST_COLOR}\]\h\[${PROMPT_COLOR_OFF}\] \
\[${PROMPT_SMALL_WORD_COLOR}\]in\[${PROMPT_COLOR_OFF}\] \
\$(_prompt_pwd)\
\$(_prompt_rcs_status) \
\$(_prompt_color_symbol_by_exit_status)\
\[${PROMPT_SYMBOL_COLOR}\]\[${PROMPT_SYMBOL}\]\[${PROMPT_COLOR_OFF}\] "

# }}}
# Load other scripts {{{

function _try_load {
  local -r file="${1:-}"
  # shellcheck source=/dev/null
  [[ -s "${file}" ]] && . "${file}"
}

_try_load /usr/local/etc/bash_completion.d/git-prompt.sh
_try_load /usr/local/etc/profile.d/autojump.sh

for config_file in "${HOME}"/.bash.d/*; do
  _try_load "${config_file}"
done

# }}}
# Functions {{{

# Open an executable by name in vim
function vimc {
  if [[ "$#" != 1 ]]; then
    return 1
  fi

  local -r target="${1}"

  if ! command -v "${target}" >/dev/null 2>&1; then
    local -r path="${HOME}/Code/shell/bin/${target}"
    touch "${path}"
    chmod +x "${path}"
    hash -r
  fi

  vim "$(command -v "${target}")"
}

# cd to the path of the foremost Finder window
function cdf {
  cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')" || return
}

# list path components
function path_parts {
  echo "${PATH}" | tr ':' '\n'
}

function check_connectivity {
  local -r curl="$(command -v curl)"
  local -r response="$("${curl}" --silent --max-redir 0 http://www.msftncsi.com/ncsi.txt)"

  if [[ "${response}" = "Microsoft NCSI" ]]; then
    printf '👍\n'
    return 0
  else
    printf '👎\n'
    return 1
  fi
}

# }}}
