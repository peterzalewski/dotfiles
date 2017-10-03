#!/usr/bin/env bash

set -eu
set -o pipefail
set -o noclobber

declare -r pwd=$(pwd)
declare -ar linked_configs=(vimrc bashrc ackrc tmux.conf psqlrc load_virtualenvwrapper.sh load_nvm.sh)

install_vim_plugins() {
  local -r vim_dir="${HOME}/.vim"
  local -r vim_plugin_loader="${vim_dir}/autoload/plug.vim"

  if [[ ! -s "${vim_plugin_loader}" ]]; then
    curl --insecure --create-dirs -sfLo "${vim_plugin_loader}" https://raw.github.com/junegunn/vim-plug/master/plug.vim
  fi

  rm -rf "${vim_dir}/plugged"
  local -r temp_vimrc=$(mktemp)
  awk '/plug#begin/,/plug#end/' ~/.vimrc >| "${temp_vimrc}"
  vim -u "${temp_vimrc}" +"PlugInstall!" +qall >/dev/null 2>&1
  rm "${temp_vimrc}"
}

copy_gitconfig() {
  [[ -f "${HOME}/.gitconfig" ]] && return

  local -r git_version=$(git --version)

  if [[ "${git_version##git version }" =~ ^1 ]]; then
    sed '/default = simple/s/simple/matching/' gitconfig >| "${HOME}/.gitconfig"
  else
    cp "${pwd}/gitconfig" "${HOME}/.gitconfig"
  fi
}

link_configs() {
  for file in "${linked_configs[@]}"; do
    [[ -f "${file}" && -s "${file}" ]] && ln -nsf "${pwd}/${file}" "${HOME}/.${file}"
  done

  local -r bashrc_dir="${HOME}/.bash.d"
  mkdir -p "${bashrc_dir}"
  for file in ${pwd}/bash.d/*; do
    [[ -f "${file}" && -s "${file}" ]] && ln -nsf "${file}" "${bashrc_dir}/${file##*/}"
  done || true
}

main() {
  link_configs
  copy_gitconfig
  install_vim_plugins
}

main "$@"
