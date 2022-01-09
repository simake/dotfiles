#!/usr/bin/env bash
set -euo pipefail

install() {
    brew install zsh
}

deps() {
    command -v brew &> /dev/null
}

exists() {
    command -v zsh &> /dev/null
}

cd $(dirname ${BASH_SOURCE[0]})
source ../try_install.sh
try_install zsh install deps exists
