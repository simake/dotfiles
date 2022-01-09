#!/usr/bin/env bash
set -euo pipefail

# https://github.com/sharkdp/hyperfine

install() {
    wget -P /tmp/ https://github.com/sharkdp/hyperfine/releases/download/v1.12.0/hyperfine_1.12.0_amd64.deb
    sudo dpkg -i /tmp/hyperfine_1.12.0_amd64.deb
    rm /tmp/hyperfine_1.12.0_amd64.deb
}

deps() {
    command -v wget &> /dev/null
}

exists() {
    command -v hyperfine &> /dev/null
}

cd $(dirname ${BASH_SOURCE[0]})
source ../try_install.sh
try_install hyperfine install deps exists
