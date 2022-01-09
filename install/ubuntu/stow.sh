#!/usr/bin/env bash
set -euo pipefail

install() {
    sudo apt update
    sudo apt install -y stow
}

deps() {
    return 0
}

exists() {
    command -v stow &> /dev/null
}

cd $(dirname ${BASH_SOURCE[0]})
source ../try_install.sh
try_install stow install deps exists
