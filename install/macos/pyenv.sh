#!/usr/bin/env bash
set -euo pipefail

install() {
    brew install pyenv
    brew install pyenv-virtualenv

    echo "
    eval \"\$(pyenv init --path)\"
    eval \"\$(pyenv init -)\"
    eval \"\$(pyenv virtualenv-init -)\"
    " >> $HOME/.zshrc.local
}

deps() {
    command -v brew &> /dev/null
}

exists() {
    command -v pyenv &> /dev/null
}

cd $(dirname ${BASH_SOURCE[0]})
source ../try_install.sh
try_install pyenv install deps exists
