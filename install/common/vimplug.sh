#!/usr/bin/env bash
set -euo pipefail

install() {
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    vim -c PlugInstall -c qa
}

deps() {
    command -v curl &> /dev/null && \
    command -v vim &> /dev/null
}

exists() {
    [ -f ~/.vim/autoload/plug.vim ]
}

cd $(dirname ${BASH_SOURCE[0]})
source ../try_install.sh
try_install vimplug install deps exists
