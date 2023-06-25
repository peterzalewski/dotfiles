#!/usr/bin/env bash

set -euo pipefail

declare -r FONT="OperatorMono"
declare -r IN_DIR="./${FONT}"
declare -r OUT_DIR="./${FONT}-Patched"

if [[ ! -d "${OUT_DIR}" ]]; then
  mkdir "${OUT_DIR}"
fi

docker -c rancher-desktop run --rm -v "${IN_DIR}":/in -v "${OUT_DIR}":/out \
  nerdfonts/patcher \
  --makegroups 3 \
  --complete \
  --careful

# vim: ft=bash
