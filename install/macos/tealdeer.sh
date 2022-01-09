#!/usr/bin/env bash
set -euo pipefail

# https://github.com/dbrgn/tealdeer

install() {
    brew install tealdeer
}

deps() {
    command -v brew &> /dev/null
}

exists() {
    command -v tldr &> /dev/null
}

cd $(dirname ${BASH_SOURCE[0]})
source ../try_install.sh
try_install tldr install deps exists
