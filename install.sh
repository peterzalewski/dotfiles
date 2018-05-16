#!/usr/bin/env bash

set -eu
set -o pipefail
set -o noclobber

declare -r BLUE="\e[0;36m"
declare -r COLOR_OFF="\e[0m"
declare -r GREEN="\e[0;32m"
declare -r TEMP_DIR=$(mktemp -d -q -t $(basename ${BASH_SOURCE[0]}))
declare -r RED="\e[0;31m"

declare -r pwd=$(pwd)
declare -r CURL=$(command -v curl)
declare -ar linked_configs=(vimrc bashrc ackrc tmux.conf psqlrc load_virtualenvwrapper.sh load_nvm.sh)

################################################################################
# Deletes the temp directory. Intended to be called automatically on script exit.
# Globals:
#   TEMP_DIR
################################################################################
function cleanup {
  rm -rf "${TEMP_DIR}"
}

################################################################################
# Prints a status message to STDOUT
# Globals:
#   BLUE
#   COLOR_OFF
# Arguments:
#   Variadic: arguments to printf. First is a formatting string. All following
#   are parameters to the formatting string.
################################################################################
function message {
  local -r msg="$1"; shift
  printf "${BLUE}INFO${COLOR_OFF} ${msg}\n" "$@"
}

################################################################################
# Prints an error message to STDERR
# Globals:
#   COLOR_OFF
#   RED
# Arguments:
#   Variadic: arguments to printf. First is a formatting string. All following
#   are parameters to the formatting string.
################################################################################
function error {
  local -r msg="$1"; shift
  printf "${RED}ERROR${COLOR_OFF} ${msg}\n" "$@" >&2
}

function install_vim_plugins {
  local -r vim=$(command -v vim)
  local -r vim_dir="${HOME}/.vim"

  if [[ ! -d "${vim_dir}" ]]; then
    if mkdir -p "${vim_dir}"; then
      message "Created vim directory at ${BLUE}%s${COLOR_OFF}" "${vim_dir}"
    else
      error "Unable to create vim directory at ${BLUE}%s${COLOR_OFF}" "${vim_dir}"
      exit 1
    fi
  fi

  local -r vim_plugin_loader="${vim_dir}/autoload/plug.vim"
  if [[ ! -s "${vim_plugin_loader}" ]]; then
    curl --insecure --create-dirs -sfLo "${vim_plugin_loader}" https://raw.github.com/junegunn/vim-plug/master/plug.vim
    message "Installed ${BLUE}vim-plug${COLOR_OFF} at ${BLUE}%s${COLOR_OFF}" "${vim_plugin_loader}"
  else
    message "Found ${BLUE}vim-plug${COLOR_OFF} at ${BLUE}%s${COLOR_OFF}" "${vim_plugin_loader}"
  fi

  if rm -rf "${vim_dir}/plugged"; then
    message "Cleared installed vim plugins from ${BLUE}%s${COLOR_OFF}" "${vim_dir}"
  else
    error "Unable to clear vim plugin directory ${BLUE}%s${COLOR_OFF}" "${vim_dir}"
    exit 1
  fi

  local -r temp_vimrc="${TEMP_DIR}/vimrc"
  awk '/plug#begin/,/plug#end/' ~/.vimrc >| "${temp_vimrc}"
  if "${vim}" -u "${temp_vimrc}" +"PlugInstall!" +qall >/dev/null 2>&1; then
    message "Installed vim plugins"
  else
    error "Unable to install vim plugins"
    exit 1
  fi
}

function copy_gitconfig {
  local -r gitconfig="${HOME}/.gitconfig"
  if [[ -f "${gitconfig}" ]]; then
    message "Found ${BLUE}%s${COLOR_OFF}" "${HOME}/.gitconfig"
    return
  fi

  local merge_strategy=
  local -r git_version=$(git --version)
  if [[ "${git_version##git version }" =~ ^1 ]]; then
    sed '/default = simple/s/simple/matching/' "${pwd}/gitconfig" >| "${gitconfig}"
    merge_strategy="matching"
  else
    cp "${pwd}/gitconfig" "${gitconfig}"
    merge_strategy="simple"
  fi

  message "Installed gitconfig with ${BLUE}%s${COLOR_OFF} default merge strategy" "${merge_strategy}"
}

function link_configs {

  local source_file= dest_file=
  for file in "${linked_configs[@]}"; do
    if [[ -f "${file}" && -s "${file}" ]]; then
      source_file="${pwd}/${file}"
      dest_file="${HOME}/.${file}"
      if ln -nsf "${source_file}" "${dest_file}"; then
        message "Linked ${BLUE}%s${COLOR_OFF} to ${BLUE}%s${COLOR_OFF}" "${source_file}" "${dest_file}"
      else
        error "Unable to link ${BLUE}%s${COLOR_OFF} to ${BLUE}%s${COLOR_OFF}" "${source_file}" "${dest_file}"
        exit 1
      fi
    fi
  done || true

  local -r bashrc_dir="${HOME}/.bash.d"
  if ! mkdir -p "${bashrc_dir}"; then
    error "Unable to create bash.d directory at ${BLUE}%s${COLOR_OFF}" "${bashrc_dir}"
  fi

  for file in ${pwd}/bash.d/*; do
    if [[ -f "${file}" && -s "${file}" ]]; then
      dest_file="${bashrc_dir}/${file##*/}"
      if ln -nsf "${file}" "${dest_file}"; then
        message "Linked ${BLUE}%s${COLOR_OFF} to ${BLUE}%s${COLOR_OFF}" "${file}" "${dest_file}"
      else
        error "Unable to link ${BLUE}%s${COLOR_OFF} to ${BLUE}%s${COLOR_OFF}" "${file}" "${dest_file}"
        exit 1
      fi
    fi
  done || true
}

function main {
  trap 'cleanup' EXIT

  link_configs
  copy_gitconfig
  install_vim_plugins
}

main "$@"
exit 0

# vim: ft=sh:sw=2:ts=2:et
