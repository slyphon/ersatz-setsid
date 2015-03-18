#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

TEMP="$(mktemp -d -t TEMP.XXXXXXX)" || _barf "failed to make tmpdir"
cleanup() { [[ -n "${TEMP:-}" ]] && rm -rf "${TEMP}"; }
trap cleanup EXIT

make clean all

SYSNAME=$(uname -s|tr 'A-Z' 'a-z')

TARGET_PATH="$TEMP/target/com/twitter/git/repo/process"

mkdir -p "${TARGET_PATH}"

for bin in setsid setpgid; do
  cp $bin "${TARGET_PATH}/${bin}.${sysname}"
done

jar cf "ersatz-setsid-${sysname}-0.1.0.jar" -C "$TEMP/target" com


