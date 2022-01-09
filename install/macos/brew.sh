#!/usr/bin/env bash
set -euo pipefail

# https://brew.sh/

install() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

deps() {
    command -v curl &> /dev/null
}

exists() {
    command -v brew &> /dev/null
}

cd $(dirname ${BASH_SOURCE[0]})
source ../try_install.sh
try_install brew install deps exists
