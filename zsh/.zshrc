# vim: set foldmethod=marker foldlevel=0 nomodeline:
# ############################################################################
# Description: focus on start up speed, colors, and shortcuts. not too wild.
# Author: Peter Zalewski <peter@zalewski.com>
# Source: https://github.com/peterzalewski/dotfiles/blob/master/bashrc
# ############################################################################

if [[ -d "/opt/local/share/zsh/site-functions" ]]; then
  fpath=( "/opt/local/share/zsh/site-functions" $fpath )
fi

# https://zsh.sourceforge.io/Doc/Release/Zsh-Modules.html#The-zsh_002fparameter-Module
zmodload zsh/parameter

# Tab completion
autoload -Uz zrecompile
autoload -Uz compinit
export ZSH_COMPDUMP="${XDG_CACHE_HOME}/zcompdump"
export INPUTRC="${ZDOTDIR}/inputrc"
compinit -i -d ${ZSH_COMPDUMP}
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Colors
autoload -U colors
colors

# vi-mode
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Aliases 

alias bc='bc --mathlib'
alias g='git'
alias gb='git branch -vv'
alias gc='git checkout'
alias gd='git d'
alias gdm='git d "$(git merge-base master HEAD)"..'
alias get='git'
alias gh5='git hist -5'
alias gh10='git hist -10'
alias got='git'
alias grep='grep --color=auto'
alias gs='git st'
alias ll='ls -alg'
alias map='xargs -n 1'
alias tpout='tput'
alias venv='python -m venv'
alias view='view -M'

if [[ "$(uname)" == "Darwin" ]]; then
  alias ghostty="/Applications/Ghostty.app/Contents/MacOS/ghostty"
fi

# Let me swear at the command prompt to sudo the previous command
declare -a fun_words
fun_words=(shit damnit fuck please)
for word in "${fun_words[@]}"; do
  # shellcheck disable=SC2139
  alias "${word}"='sudo $(fc -ln -1)'
done


# Default programs and settings 

if command -v nvim &>/dev/null; then
  alias v='nvim'
  alias vi='nvim'
  alias vim='nvim'
  alias nvum='nvim'
fi

# Use vi-like bindings instead of emacs-like bindings to edit
bindkey -v

setopt AUTO_CD
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'


# History 

# Do not log adjacent duplicates
setopt HIST_IGNORE_DUPS

# Do not log commands (or alias expansions) that start with a space
setopt HIST_IGNORE_SPACE

# Append commands to history as soon as they are entered
setopt INC_APPEND_HISTORY

# Why doesn't zsh set a history file by default?
export HISTFILE="${XDG_CACHE_HOME}/zsh_history"

# Let's keep lots of history overall
export SAVEHIST=1000000

# And a lot per session
export HISTSIZE=1000000

# Ignore common drudgery
export HISTORY_IGNORE='(ls|ll|bg|fg|history|clear|jobs|exit|gd|gs|reset)'

# Use ISO8601 for history timestamps
export HISTTIMEFORMAT='%Y-%m-%dT%H:%M:%S%z '


# Colors and appearance 

# Colorize ls/eza
if command -v eza &>/dev/null; then
  alias ls='eza'
  alias tree='eza -T'
else
  case "$(uname)" in
    Darwin) alias ls="ls -hG" ;;
    *) alias ls='ls --group-directories-first --color -h' ;;
  esac
fi

if [[ -n "$(command -v grc)" ]]; then
  alias colorify="grc -es --colour=auto"
  for app in {ps,du,df,lsof,ifconfig,ping,traceroute,dig}; do
    alias "${app}"="colorify "${app}""
  done
fi


# Prompt 

# Perform expansion of %m for hostname, %n for username, etc in the prompt string
setopt PROMPT_PERCENT

# Perform parameter, command, and math substitution in the prompt string
setopt PROMPT_SUBST

# Create a prompt like this, with colors (escape sequences) set with the
# variables listed below:
#
# username at host in directory [on branch] ❯
# *        |  *       |             *       |
# |        |  |       |             |       +-> PROMPT_SUCCESS/FAILURE
# |        |  |       |             +--------*> PROMPT_RCS
# |        |  |       +-----------------------> PROMPT_DIR
# |        |  +------------------------------*> PROMPT_HOST
# |        +----------------------------------> PROMPT_WORD
# +------------------------------------------*> PROMPT_USER

declare COLOR_OFF="$reset_color"
declare PROMPT_WORD="\e[1;3;38m"
declare PROMPT_DIR="$fg_bold[yellow]"
declare PROMPT_HOST="$fg_bold[green]"
declare PROMPT_RCS="$fg_bold[red]"
declare PROMPT_SUCCESS="$fg_bold[white]"
declare PROMPT_USER="$fg_bold[magenta]"
declare PROMPT_FAILURE="$fg_bold[red]"
declare PROMPT_VIRTUALENV="$fg_bold[green]"

function _prompt_user {
  if [[ "${USER}" = "${OMITTED_USER}" ]]; then
    echo "%{$PROMPT_USER%}I%{$COLOR_OFF%}%{$PROMPT_WORD%} am %{$COLOR_OFF%}"
  else
    echo "%{${PROMPT_USER}%}%n%{${COLOR_OFF}%}%{${PROMPT_WORD}%} is %{${COLOR_OFF}%}"
  fi
}

function _prompt_hostname_if_not_own {
  if [[ "${HOSTNAME:-"${HOST}"}" != "${OMITTED_HOSTNAME}" ]]; then
    echo "%{${PROMPT_WORD}%}at%{${COLOR_OFF}%} %{${PROMPT_HOST}%}%m%{${COLOR_OFF}%} "
  else
    echo ""
  fi
}

# Replace ~ in the current path with 🏠
function _prompt_pwd {
  declare -r PWD_WITHOUT_HOME="${PWD#$HOME}"
  if [[ "${PWD}" != "${PWD_WITHOUT_HOME}" ]]; then
    echo "%{${PROMPT_WORD}%}in%{${COLOR_OFF}%} 🏠%{${PROMPT_DIR}%}${PWD_WITHOUT_HOME}%{${COLOR_OFF}%}"
  else
    echo "%{${PROMPT_WORD}%}in%{${COLOR_OFF}%} %{${PROMPT_DIR}%}%d%{${COLOR_OFF}%}"
  fi
}

# Evaluate __git_ps1 if it is available
function _prompt_rcs_status {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    echo " %{${PROMPT_WORD}%}on%{${COLOR_OFF}%} %{${PROMPT_RCS}%} $(git symbolic-ref --short HEAD)%{${COLOR_OFF}%}"
  else
    echo ""
  fi
}

# Display the prompt symbol in red if the last shell command failed
function _prompt_color_symbol_by_exit_status {
  echo "%(?.%{${PROMPT_SUCCESS}%}❯%{${COLOR_OFF}%}.%{${PROMPT_FAILURE}%}❯%{${COLOR_OFF}%})"
}

export VIRTUAL_ENV_DISABLE_PROMPT=1
function _prompt_virtualenv {
  if [[ -n "${VIRTUAL_ENV}" ]]; then
    echo " 🐍%{${PROMPT_VIRTUALENV}%}$(basename "${VIRTUAL_ENV}")%{${COLOR_OFF}%}"
  else
    echo ""
  fi
}

export PROMPT='\
$(_prompt_user)\
$(_prompt_hostname_if_not_own)\
$(_prompt_pwd)\
$(_prompt_rcs_status)\
$(_prompt_virtualenv)\
$(_prompt_color_symbol_by_exit_status) '


# Functions 

# rbenv init is slow because it requires eval and rehash. I know I want
# to use it, so just declare the same function that init does, here, and
# add the shims directory to the PATH in .bash_profile. Works out the same.
function rbenv {
  local -r subcommand="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "${subcommand}" in
  rehash|shell)
    eval "$(rbenv "sh-${subcommand}" "$@")"
    ;;
  *)
    command rbenv "${subcommand}" "$@"
    ;;
  esac
}

# Same thing goes for pyenv.
function pyenv {
  local -r subcommand="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "${subcommand}" in
  rehash|shell)
    eval "$(pyenv "sh-${subcommand}" "$@")"
    ;;
  *)
    command pyenv "${subcommand}" "$@"
    ;;
  esac
}

# Open an executable by name in vim
function vimc {
  if [[ "$#" != 1 || -z "${1:-}" ]]; then
    return 1
  fi

  local -r target="${HOME}/bin/${1}"
  if command -v "$1" >/dev/null 2>&1 && [[ ! -e "${target}" ]]; then
    echo "Executable $1 already exists in another path. Choose another name."
    return 2
  fi

  if [[ ! -x "${target}" ]]; then
    cat > "${target}" <<- EOM
			#!/usr/bin/env bash

			set -euo pipefail

			function main {
			}

			main "\$@"
			exit 0

			# vim: ft=sh:sw=2:ts=2:et
		EOM
    chmod +x "${target}"
  fi

  vim "${target}"
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

alias gco='git checkout $(choose_git_branch)'
function choose_git_branch() {
  git for-each-ref --format='%(refname:short)%09%(contents:subject)' 'refs/heads' |\
    sort |\
    cut -b 1-80 |\
    column -t -s '	' |\
    fzf \
      --prompt="Choose branch: " \
      --pointer='ᐅ' \
      --height 40% \
      --reverse |\
    cut -d ' ' -f 1
}

function safe_unalias() {
  unalias "$1" 2> /dev/null || true
}


# Load other scripts 

function _try_load {
  local -r file="${1:-}"
  # shellcheck source=/dev/null
  [[ -s "${file}" ]] && . "${file}"
}

for config_file in "${ZDOTDIR}"/autoload/*; do
  _try_load "${config_file}"
done

_try_load "${ZDOTDIR}/autoload/fzf-tab/fzf-tab.plugin.zsh"
_try_load "${ZDOTDIR}/autoload/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
_try_load "${HOME}/.zshrc.user"
_try_load "${HOME}/.nix-profile/etc/profile.d/nix.sh"

if [[ -n $(command -v direnv) ]]; then
  eval "$(direnv hook zsh)"
fi

if command -v atuin &>/dev/null; then
  eval "$(atuin init zsh)"
fi

