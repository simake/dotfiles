#!/usr/bin/env bash
set -euo pipefail

install() {
    sudo apt update
    sudo apt install -y zsh
}

deps() {
    command -v apt &> /dev/null
}

exists() {
    command -v zsh &> /dev/null
}

cd $(dirname ${BASH_SOURCE[0]})
source ../try_install.sh
try_install zsh install deps exists
