#!/bin/bash

unalias nvm
export NVM_DIR="${HOME}/.nvm"
if [[ -s "${NVM_DIR}/nvm.sh" ]]; then
  . "${NVM_DIR}/nvm.sh" 
elif [[ -s "/usr/local/opt/nvm/nvm.sh" ]]; then
  . "/usr/local/opt/nvm/nvm.sh"
fi
