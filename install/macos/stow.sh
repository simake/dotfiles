#!/usr/bin/env bash
set -euo pipefail

install() {
    brew install stow
}

deps() {
    command -v brew &> /dev/null
}

exists() {
    command -v stow &> /dev/null
}

cd $(dirname ${BASH_SOURCE[0]})
source ../try_install.sh
try_install stow install deps exists
