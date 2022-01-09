#!/usr/bin/env bash
set -euo pipefail

install() {
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --bin

    echo '
    # FZF
    export PATH="$PATH:$HOME/.fzf/bin"
    source "$HOME/.fzf/shell/completion.zsh"
    source "$HOME/.fzf/shell/key-bindings.zsh"
    ' >> $HOME/.zshrc.local
}

deps() {
    command -v git &> /dev/null
}

exists() {
    command -v fzf &> /dev/null
}

cd $(dirname ${BASH_SOURCE[0]})
source ../try_install.sh
try_install fzf install deps exists
