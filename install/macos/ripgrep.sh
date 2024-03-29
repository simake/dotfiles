#!/usr/bin/env bash
set -euo pipefail

install() {
    brew install ripgrep
}

deps() {
    command -v brew &> /dev/null
}

exists() {
    command -v rg &> /dev/null
}

cd $(dirname ${BASH_SOURCE[0]})
source ../try_install.sh
try_install ripgrep install deps exists
