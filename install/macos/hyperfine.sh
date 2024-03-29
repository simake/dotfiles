#!/usr/bin/env bash
set -euo pipefail

# https://github.com/sharkdp/hyperfine

install() {
    brew install hyperfine
}

deps() {
    command -v brew &> /dev/null
}

exists() {
    command -v hyperfine &> /dev/null
}

cd $(dirname ${BASH_SOURCE[0]})
source ../try_install.sh
try_install hyperfine install deps exists
