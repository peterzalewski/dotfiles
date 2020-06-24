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
alias gdm='git d "$(git merge-base master HEAD)"..'
alias get='git'
alias gh='git hist'
alias gh5='git hist -5'
alias gh10='git hist -10'
alias got='git'
alias grep='grep --color=auto'
alias gs='git st'
alias ll='ls -al'
alias map='xargs -n 1'
alias tpout='tput'
alias venv='python -m venv'
alias view='view -M'

# Let me swear at the command prompt to sudo the previous command
declare -a fun_words=(shit damnit fuck please)
for word in "${fun_words[@]}"; do
  # shellcheck disable=SC2139
  alias "${word}"='sudo $(fc -ln -1)'
done

# }}}
# Default programs and settings {{{

if [[ -n "$(command -v nvim)" ]]; then
  export EDITOR='nvim'
  alias vim='nvim'
  alias nvum='nvim'
else
  export EDITOR='vim'
fi

export FZF_DEFAULT_COMMAND='rg --files --follow --glob=!{.git,node_modules}'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_DEFAULT_OPTS='--color=dark --color=fg:15,bg:0,hl:1,fg+:#FFFFFF,bg+:0,hl+:1,prompt:3,pointer:3,marker:5,spinner:11,header:-1,info:6 --layout=reverse --info=hidden --prompt="❯ "'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
declare -a less_options=(
  --LONG-PROMPT
  --RAW-CONTROL-CHARS
  --hilite-search
  --ignore-case
  --no-init
  --quit-if-one-screen
)
export LESS="${less_options[*]}"
export LESSHISTFILE='-'
export PAGER='less'
export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"
export VISUAL="${EDITOR}"

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
export HISTIGNORE='ls:ll:bg:fg:history:clear:jobs:exit:gd:gs:reset'

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

function man() {
  LESS_TERMCAP_md="$(tput bold; tput setaf 6)" \
  LESS_TERMCAP_me="$(tput sgr0)" \
  LESS_TERMCAP_so="$(tput bold ; tput setaf 1)" \
  LESS_TERMCAP_se="$(tput sgr0)" \
  LESS_TERMCAP_us="$(tput bold ; tput setaf 3)" \
  LESS_TERMCAP_ue="$(tput sgr0)" \
  command man "$@"
}

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

declare PROMPT_COLOR_OFF="\001$(tput sgr0)\002"

# Bold
declare PROMPT_SMALL_WORD_COLOR="\001$(tput bold ; tput sitm)\002"

# Bold + yellow
declare PROMPT_DIR_COLOR="\001$(tput bold ; tput setaf 3)\002"

# Bold + green
declare PROMPT_HOST_COLOR="\001$(tput bold ; tput setaf 10)\002"

# Bold + red
declare PROMPT_RCS_COLOR="\001$(tput bold ; tput setaf 1)\002"

# '❯'
declare PROMPT_SYMBOL=$'\001\xE2\x9D\xAF\002'

# Bold + white
declare PROMPT_SYMBOL_COLOR="\001$(tput bold ; tput setaf 15)\002"

# Bold + magenta
declare PROMPT_USER_COLOR="\001$(tput bold ; tput setaf 13)\002"

# Bold + red
declare PROMPT_LAST_COMMAND_FAILED="\001$(tput bold ; tput setaf 1)\002"

# Bold + green
declare PROMPT_VIRTUALENV_COLOR="\001$(tput bold; tput setaf 2)\002"

function _prompt_user {
  if [[ "${USER}" = "${KITTY_USER}" ]]; then
    printf "${PROMPT_USER_COLOR}I${PROMPT_COLOR_OFF}${PROMPT_SMALL_WORD_COLOR} am "
  else
    printf "${PROMPT_USER_COLOR}${USER}${PROMPT_COLOR_OFF}${PROMPT_SMALL_WORD_COLOR} is "
  fi
}

function _prompt_hostname_if_not_own {
  if [[ "${HOSTNAME}" != "${KITTY_HOSTNAME}" ]]; then
    printf "${PROMPT_SMALL_WORD_COLOR}at${PROMPT_COLOR_OFF} \
${PROMPT_HOST_COLOR}${HOSTNAME}${PROMPT_COLOR_OFF} "
  else
    printf ""
  fi
}

# Replace ~ in the current path with 🏠
function _prompt_pwd {
  declare -r PWD_WITHOUT_HOME="${PWD#$HOME}"
  if [[ "${PWD}" != "${PWD_WITHOUT_HOME}" ]]; then
    printf "\001🏠\002${PROMPT_DIR_COLOR}${PWD_WITHOUT_HOME}${PROMPT_COLOR_OFF}"
  else
    printf "${PROMPT_DIR_COLOR}${PWD}${PROMPT_COLOR_OFF}"
  fi
}

# Evaluate __git_ps1 if it is available
function _prompt_rcs_status {
  if [[ -n "$(type -t __git_ps1)" ]]; then
    printf "$(__git_ps1 " ${PROMPT_SMALL_WORD_COLOR}on${PROMPT_COLOR_OFF} \
${PROMPT_RCS_COLOR} %s${PROMPT_COLOR_OFF}")"
  else
    printf ""
  fi
}

# Display the prompt symbol in red if the last shell command failed
function _prompt_color_symbol_by_exit_status {
  if [[ "${LAST_EXIT}" != 0 ]]; then
    printf "${PROMPT_LAST_COMMAND_FAILED}${PROMPT_SYMBOL}${PROMPT_COLOR_OFF}"
  else
    printf "${PROMPT_SYMBOL_COLOR}${PROMPT_SYMBOL}${PROMPT_COLOR_OFF}"
  fi
}

export VIRTUAL_ENV_DISABLE_PROMPT=1
function _prompt_virtualenv {
  if [[ -n "${VIRTUAL_ENV}" ]]; then
    printf " \001🐍\002${PROMPT_VIRTUALENV_COLOR}"$(basename "${VIRTUAL_ENV}")"${PROMPT_COLOR_OFF}"
  else
    printf ""
  fi
}

# Save the exit code of the last shell command. This must happen
# before functions to build the prompt are called.
function _prompt_save_last_exit {
  export LAST_EXIT="$?"
}

export PROMPT_COMMAND="_prompt_save_last_exit"
export PS1="\
\$(_prompt_user)\
\$(_prompt_hostname_if_not_own)\
${PROMPT_SMALL_WORD_COLOR}in${PROMPT_COLOR_OFF} \
\$(_prompt_pwd)\
\$(_prompt_rcs_status)\
\$(_prompt_virtualenv)\
\$(_prompt_color_symbol_by_exit_status) "

# }}}
# Load other scripts {{{

function _try_load {
  local -r file="${1:-}"
  # shellcheck source=/dev/null
  [[ -s "${file}" ]] && . "${file}"
}

_try_load /usr/local/etc/bash_completion.d/git-prompt.sh
_try_load /usr/local/etc/bash_completion.d/git-completion.bash
_try_load /usr/local/etc/profile.d/z.sh

for config_file in "${HOME}"/.bash.d/*; do
  _try_load "${config_file}"
done

declare rbenv="$(command -v rbenv)"
if [[ -n "${rbenv}" ]]; then
  eval "$("${rbenv}" init -)"
fi
unset rbenv

# }}}
# Functions {{{

# Open an executable by name in vim
function vimc {
  if [[ "$#" != 1 ]]; then
    return 1
  fi

  local -r target="${1}"

  if ! command -v "${target}" >/dev/null 2>&1; then
    local -r filename="${HOME}/Code/shell/bin/${target}"
    cat > "${filename}" <<- EOM
			#!/usr/bin/env bash

			set -euo pipefail

			function main {
			}

			main "\$@"
			exit 0

			# vim: ft=sh:sw=2:ts=2:et
		EOM
    chmod +x "${filename}"
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
  echo "${PATH}" | tr ':' '\n' | nl
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

function print_colors() {
  for i in {0..255} ; do
    printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
    if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 6 == 0 )); then
        printf "\n";
    fi
  done
}

# }}}
