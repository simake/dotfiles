#!/usr/bin/env bash
set -euo pipefail

kernel="$(uname)"
active_OS="other"
if [[ "$kernel" == "Darwin" ]]; then
    active_OS="macos"
elif [[ "$kernel" == "Linux" ]]; then
    distro="$(lsb_release -is)"
    if [[ "$distro" == "Ubuntu" ]]; then
        active_OS="ubuntu"
    fi
fi

dotfiles="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $dotfiles/install

echo -e "\nInstalling programs.\n"

case "$active_OS" in

    "macos")
        ./macos/brew.sh
        ./macos/stow.sh
        ./macos/ripgrep.sh
        ./macos/fd.sh
        ./macos/pyenv.sh
        ./macos/tealdeer.sh
        ./macos/hyperfine.sh
        ./macos/zsh.sh
        ./macos/vim.sh
        ./common/vimplug.sh
        ./common/fzf.sh
        ./common/tpm.sh
        ;;

    "ubuntu")
        ./ubuntu/stow.sh
        ./ubuntu/ripgrep.sh
        ./ubuntu/fd.sh
        ./ubuntu/pyenv.sh
        ./ubuntu/tealdeer.sh
        ./ubuntu/hyperfine.sh
        ./ubuntu/zsh.sh
        ./common/vimplug.sh
        ./common/fzf.sh
        ./common/tpm.sh
        ;;

    *)
        echo "Error: OS not recognized."
        exit 1
esac
