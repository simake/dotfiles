#!/usr/bin/env bash
set -euo pipefail

# https://github.com/ycm-core/YouCompleteMe/wiki/Building-Vim-from-source
# https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/vim.rb

install() {
    git clone https://github.com/vim/vim.git /tmp/vim/
    cd /tmp/vim/
    ./configure --prefix=/usr/local/stow/vim/ --with-features=huge -enable-multibyte --enable-cscope
    make -j8 VIMRUNTIMEDIR=/usr/local/share/vim/vim82
    sudo make install
    sudo stow -d /usr/local/stow vim
}

deps() {
    command -v git &> /dev/null && \
    command -v make &> /dev/null && \
    command -v stow &> /dev/null
}

exists() {
    # also make sure that it isn't the default build by apple
    # which currently lacks things like termguicolors support
    command -v vim &> /dev/null && \
    ! vim --version | grep "Compiled by root@apple.com" &> /dev/null
}

cd $(dirname ${BASH_SOURCE[0]})
source ../try_install.sh
try_install vim install deps exists
