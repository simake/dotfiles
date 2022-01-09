#!/usr/bin/env bash
set -euo pipefail

install() {
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
    sudo dpkg -i ripgrep_11.0.2_amd64.deb
    rm ripgrep_11.0.2_amd64.deb
}

deps() {
    command -v curl &> /dev/null
}

exists() {
    command -v rg &> /dev/null
}

cd $(dirname ${BASH_SOURCE[0]})
source ../try_install.sh
try_install ripgrep install deps exists
