#!/usr/bin/env bash
set -euo pipefail

# https://github.com/dbrgn/tealdeer

install() {
    wget -P $HOME/bin/ -O tldr https://github.com/dbrgn/tealdeer/releases/download/v1.4.1/tldr-linux-x86_64-musl
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
