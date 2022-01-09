#!/usr/bin/env bash
set -euo pipefail

# https://github.com/sharkdp/fd

install() {
    brew install fd
}

deps() {
    command -v brew &> /dev/null
}

exists() {
    command -v fd &> /dev/null
}

cd $(dirname ${BASH_SOURCE[0]})
source ../try_install.sh
try_install fd install deps exists
