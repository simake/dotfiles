#!/usr/bin/env bash
set -e

kernel="$(uname)"

system_type="other"
if [[ "$kernel" == "Darwin" ]]; then
    system_type="macos"
elif [[ "$kernel" == "Linux" ]]; then
    distro="$(lsb_release -is)"
    if [[ "$distro" == "Ubuntu" ]]; then
        system_type="ubuntu"
    fi
fi
echo "system_type identified as $system_type"

dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing pyenv..."
case $system_type in
    "macos")
        $dotfiles_dir/install/macos/pyenv.sh
        ;;

    "ubuntu")
        $dotfiles_dir/install/ubuntu/pyenv.sh
        ;;

    *)
        echo "Unknown system_type"
        exit 1
        ;;
esac
eval "$(pyenv init --path)"

echo "Installing python..."
latest_python_version=$(pyenv install --list | grep --extended-regexp "^\s*[0-9][0-9.]*[0-9]\s*$" | tail -1)
pyenv install $latest_python_version

echo "Installing ansible..."
pip install ansible

echo "System bootstrapped with ansible!"
