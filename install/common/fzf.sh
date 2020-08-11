#!/usr/bin/env bash

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin

echo '
# FZF
export PATH="$PATH:$HOME/.fzf/bin"
source "$HOME/.fzf/shell/completion.zsh"
source "$HOME/.fzf/shell/key-bindings.zsh"
' >> $HOME/.zshrc.local
