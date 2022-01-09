#!/usr/bin/env bash
set -euo pipefail

# https://github.com/sharkdp/fd

install() {
    wget -P /tmp/ https://github.com/sharkdp/fd/releases/download/v8.3.0/fd_8.3.0_amd64.deb
    sudo dpkg -i /tmp/fd_8.3.0_amd64.deb
    rm /tmp/fd_8.3.0_amd64.deb
}

deps() {
    command -v wget &> /dev/null
}

exists() {
    command -v fd &> /dev/null
}

cd $(dirname ${BASH_SOURCE[0]})
source ../try_install.sh
try_install fd install deps exists
