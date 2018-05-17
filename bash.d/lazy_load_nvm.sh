#!/usr/bin/env bash

#/ Sourcing nvm.sh on every new shell is expensive and adds significantly to the
#/ startup time. Lazily load nvm, npm, and node to favor shell startup speed.

function _lazy_load_nvm {
  unset -f _lazy_load_nvm nvm npm node
  export NVM_DIR="${HOME}/.nvm"
  if [[ -s "${NVM_DIR}/nvm.sh" ]]; then
    . "${NVM_DIR}/nvm.sh" 
  fi
}

function nvm {
  _lazy_load_nvm
  nvm "$@"
}

function npm {
  _lazy_load_nvm
  npm "$@"
}

function node {
  _lazy_load_nvm
  node "$@"
}
