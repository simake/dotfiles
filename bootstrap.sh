#!/usr/bin/env bash
set -euo pipefail

dotfiles="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $dotfiles

./link.sh
./install.sh

chsh -s $(which zsh)
