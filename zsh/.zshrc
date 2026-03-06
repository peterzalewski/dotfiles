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
# Only regenerate compdump once a day
() {
  setopt localoptions extendedglob
  if [[ -n ${ZSH_COMPDUMP}(#qN.mh+24) ]]; then
    compinit -d "${ZSH_COMPDUMP}"
  else
    compinit -C -d "${ZSH_COMPDUMP}"
  fi
}
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
alias ga='git add'
alias gap='git add --patch'
alias gb='git branch -vv'
alias gc='git checkout'
alias gd='git d'
alias gdc='git d --cached'
alias gdm='git d "$(git merge-base refs/remotes/origin/HEAD HEAD)"..'
alias gl="git hist"
alias gl5='git hist -5'
alias gl10='git hist -10'
alias grep='grep --color=auto'
alias gs='git st'
alias map='xargs -n 1'
alias tpout='tput'
alias venv='python3 -m venv'

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
  for word in "v" "vi" "vim" "nv" "nvum"; do
    alias "${word}"="nvim"
  done
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
  alias ls='eza --group-directories-first --icons'
  alias ll='eza --long --all --group --git --group-directories-first --icons --color-scale=size'
  alias tree='eza --tree --icons'
else
  case "$(uname)" in
    Darwin) alias ls="ls -hG" ;;
    *) alias ls='ls --group-directories-first --color -h' ;;
  esac
  alias ll='ls -alg'
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

# ░▒▓ ~/directory  branch  venv  N [exit]❯
#
# Catppuccin Frappe palette
declare COLOR_OFF=$'\e[0m'
declare PROMPT_JOBS=$'\e[38;2;181;191;226m'         # Subtext1 #b5bfe2
declare PROMPT_DIR=$'\e[38;2;242;213;207m'          # Rosewater #f2d5cf
declare PROMPT_HOST=$'\e[38;2;186;187;241m'         # Lavender #babbf1
declare PROMPT_RCS_CLEAN=$'\e[38;2;166;209;137m'    # Green    #a6d189
declare PROMPT_RCS_DIRTY=$'\e[38;2;202;158;230m'    # Mauve    #ca9ee6
declare PROMPT_SUCCESS=$'\e[38;2;198;208;245m'      # Text     #c6d0f5
declare PROMPT_USER=$'\e[38;2;186;187;241m'         # Lavender #babbf1
declare PROMPT_FAILURE=$'\e[38;2;231;130;132m'      # Red      #e78284
declare PROMPT_VIRTUALENV=$'\e[38;2;129;200;190m'   # Teal     #81c8be

# Three-character gradient to identify the machine.
# Darwin = peach, Docker = blue, SSH = user@host.
# Set PROMPT_DOCKER_HOSTS=( hostname1 hostname2 ) in .zshrc.user/.zshrc.local
# to match your Docker containers.
function _prompt_host_gradient {
  local color
  if [[ "$(uname)" == "Darwin" ]]; then
    color='239;159;118'   # Peach #ef9f76
  elif (( ${+PROMPT_DOCKER_HOSTS} )) && (( ${PROMPT_DOCKER_HOSTS[(Ie)${HOST}]} )); then
    color='140;170;238'   # Blue  #8caaee
  elif [[ -n "${SSH_TTY:-}" ]]; then
    echo "%{${PROMPT_USER}%}%n%{${COLOR_OFF}%}@%{${PROMPT_HOST}%}%m%{${COLOR_OFF}%} "
    return
  else
    return
  fi
  printf '%%{\e[38;2;%sm%%}░▒▓%%{\e[0m%%} ' "$color"
}

# Show current directory with ~ for $HOME.
# Abbreviate intermediate components to their first character when path > 30 chars.
function _prompt_pwd {
  local dir="${PWD/#$HOME/~}"
  if (( ${#dir} > 30 )) && (( ${#${(@s:/:)dir}} > 2 )); then
    local parts=("${(@s:/:)dir}")
    local prefix=""
    [[ "${dir}" == /* ]] && prefix="/"
    local i
    for (( i=1; i<${#parts}; i++ )); do
      [[ -n "${parts[$i]}" ]] && prefix+="${parts[$i][1]}/"
    done
    dir="${prefix}${parts[-1]}"
  fi
  echo "%{${PROMPT_DIR}%}${dir}%{${COLOR_OFF}%}"
}

# Show branch with icon: green if clean, mauve if dirty.
function _prompt_rcs_status {
  local branch
  branch="$(git symbolic-ref --short HEAD 2>/dev/null)" || return
  echo " %{${PROMPT_RCS_DIRTY}%} ${branch}%{${COLOR_OFF}%}"
}

# Show [exit_code] or [SIGNAME] in red before ❯ if the last command failed.
# Exit status is captured in a precmd hook to survive prompt subshells.
function _prompt_save_exit_status { _PROMPT_EXIT=$? }
precmd_functions=(_prompt_save_exit_status $precmd_functions)

function _prompt_exit_symbol {
  if (( _PROMPT_EXIT == 0 )); then
    echo "%{${PROMPT_SUCCESS}%}❯%{${COLOR_OFF}%}"
  elif (( _PROMPT_EXIT > 128 )); then
    local sig="$(kill -l $((_PROMPT_EXIT - 128)) 2>/dev/null)"
    echo " %{${PROMPT_FAILURE}%}[SIG${sig:-$_PROMPT_EXIT}]%{${COLOR_OFF}%}%{${PROMPT_SUCCESS}%}❯%{${COLOR_OFF}%}"
  else
    echo " %{${PROMPT_FAILURE}%}[${_PROMPT_EXIT}]%{${COLOR_OFF}%}%{${PROMPT_SUCCESS}%}❯%{${COLOR_OFF}%}"
  fi
}

export VIRTUAL_ENV_DISABLE_PROMPT=1
function _prompt_virtualenv {
  if [[ -n "${VIRTUAL_ENV}" ]]; then
    echo " %{${PROMPT_VIRTUALENV}%} $(basename "${VIRTUAL_ENV}")%{${COLOR_OFF}%}"
  else
    echo ""
  fi
}

export PROMPT='\
$(_prompt_host_gradient)\
$(_prompt_pwd)\
$(_prompt_rcs_status)\
$(_prompt_virtualenv)\
%(1j. %{${PROMPT_JOBS}%} %j%{${COLOR_OFF}%}.)\
$(_prompt_exit_symbol) '

# Terminal title: show git repo root + cwd when idle, command when running
function _title_precmd {
  local repo
  repo="$(git rev-parse --show-toplevel 2>/dev/null)" && repo="${repo:t}" || repo="${PWD:t}"
  print -Pn "\e]0;${repo}\a"
}

function _title_preexec {
  local repo
  repo="$(git rev-parse --show-toplevel 2>/dev/null)" && repo="${repo:t}" || repo="${PWD:t}"
  print -Pn "\e]0;${1%% *} ${repo}\a"
}

precmd_functions+=(_title_precmd)
preexec_functions+=(_title_preexec)

# Functions


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

# Replace zsh's tab-completion menu to one powered by fzf
_try_load "${ZDOTDIR}/autoload/fzf-tab/fzf-tab.plugin.zsh"

# Syntax highlighting for CLI: command names, string literals, etc.
_try_load "${ZDOTDIR}/autoload/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Host-specific functions and env vars
_try_load "${HOME}/.zshrc.user"
_try_load "${HOME}/.nix-profile/etc/profile.d/nix.sh"

# Cache eval output from slow init commands. Regenerate when the binary changes.
function _cached_eval {
  local cmd="$1" cache="${XDG_CACHE_HOME}/zsh_${1}_init.zsh"
  local bin="$(command -v "$cmd" 2>/dev/null)" || return
  if [[ ! -s "$cache" || "$bin" -nt "$cache" ]]; then
    case "$cmd" in
      atuin) "$bin" init zsh > "$cache" ;;
      zoxide) "$bin" init zsh > "$cache" ;;
    esac
  fi
  . "$cache"
}

command -v mise &>/dev/null && eval "$(mise activate zsh)"
command -v atuin &>/dev/null && _cached_eval atuin
command -v zoxide &>/dev/null && _cached_eval zoxide
