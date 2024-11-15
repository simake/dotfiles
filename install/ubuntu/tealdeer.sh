#!/usr/bin/env bash
set -euo pipefail

# https://github.com/dbrgn/tealdeer

install() {
    curl -fLo $HOME/bin/tldr --create-dirs \
        https://github.com/tealdeer-rs/tealdeer/releases/download/v1.7.0/tealdeer-linux-x86_64-musl
    chmod +x $HOME/bin/tldr
}

deps() {
    command -v wget &> /dev/null
}

exists() {
    command -v tldr &> /dev/null
}

cd $(dirname ${BASH_SOURCE[0]})
source ../try_install.sh
try_install tldr install deps exists
