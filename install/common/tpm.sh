#!/usr/bin/env bash
set -euo pipefail

install() {
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

deps() {
    command -v git &> /dev/null
}

exists() {
    [ -d ~/.tmux/plugins/tpm ]
}

cd $(dirname ${BASH_SOURCE[0]})
source ../try_install.sh
try_install tpm install deps exists
