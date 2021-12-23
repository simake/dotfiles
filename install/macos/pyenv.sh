#!/usr/bin/env bash

brew install pyenv
brew install pyenv-virtualenv

echo "
eval \"\$(pyenv init --path)\"
eval \"\$(pyenv virtualenv-init -)\"
" >> $HOME/.zshrc.local
