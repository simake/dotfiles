#!/usr/bin/env bash
set -euo pipefail

# https://github.com/sharkdp/hyperfine

install() {
	brew install lazygit
}

deps() {
	command -v brew &>/dev/null
}

exists() {
	command -v lazygit &>/dev/null
}

cd $(dirname ${BASH_SOURCE[0]})
source ../try_install.sh
try_install lazygit install deps exists
