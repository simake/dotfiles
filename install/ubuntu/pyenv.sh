#!/usr/bin/env bash
set -euo pipefail

# https://realpython.com/intro-to-pyenv/#installing-pyenv

install() {
    sudo apt update
    sudo apt install -y make build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
        libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl

    export PYENV_ROOT="$HOME/.pyenv"

    curl https://pyenv.run | bash

    echo "
    export PATH=\"${PYENV_ROOT}/bin:\$PATH\"
    eval \"\$(pyenv init --path)\"
    eval \"\$(pyenv init -)\"
    eval \"\$(pyenv virtualenv-init -)\"
    " >> $HOME/.zshrc.local
}

deps() {
    command -v apt &> /dev/null && \
    command -v curl &> /dev/null
}

exists() {
    command -v pyenv &> /dev/null
}

cd $(dirname ${BASH_SOURCE[0]})
source ../try_install.sh
try_install pyenv install deps exists
