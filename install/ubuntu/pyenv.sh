#!/usr/bin/env bash

sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
    libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl

export PYENV_ROOT="$HOME/.pyenv"

curl https://pyenv.run | bash

echo "
export PATH=\"${PYENV_ROOT}/bin:\$PATH\"
eval \"\$(pyenv init --path)\"
eval \"\$(pyenv virtualenv-init -)\"
" >> $HOME/.zshrc.local

# Source: https://realpython.com/intro-to-pyenv/#installing-pyenv

