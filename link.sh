#!/usr/bin/env bash
set -eo pipefail

if [[ "$1" = "-y" ]]; then
    skip_prompt="yes"
fi

dotfiles="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $dotfiles

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

# Files in the link folder are linked to $HOME by default.
# Use the mappings below to override the defaults or add
# new source->destination mappings, with OS criteria.
declare -A mapping_overrides=(
    # mapping template: ["SRC"]="OS,DST"
    [".vscode.settings.json"]="macos,$HOME/Library/Application Support/Code/User/settings.json"
    # Note: plists are replaced upon saving, breaking the link
    ["com.googlecode.iterm2.plist"]="macos,$HOME/Library/Preferences/com.googlecode.iterm2.plist"
)

declare -A mappings

link_dir="link"
for SRC in $(find $link_dir -mindepth 1); do
    if ! [[ -v mapping_overrides[$SRC] ]]; then
        mappings[$SRC]="any,$HOME/$(basename $SRC)"
    fi
done

for SRC in "${!mapping_overrides[@]}"; do
    IFS=',' read -ra values <<< ${mapping_overrides[$SRC]}
    OS=${values[0]}
    DST=${values[1]}
    if [[ $OS == $active_OS ]]; then
        mappings[$SRC]="$OS,$DST"
    fi
done

existing_files=""
for rhs in "${mappings[@]}"; do
    IFS=',' read -ra values <<< "$rhs"
    OS=${values[0]}
    DST=${values[1]}
    if [[ -e $DST ]]; then
        existing_files="$existing_files $DST"
    fi
done

if [[ -n "$existing_files" && -z "$skip_prompt" ]]; then
    echo -e "\nThe following files already exist:"
    printf "%s\n" $existing_files
    echo -e "\nThese files will be replaced."
    read -p "Is that okay? [y/N] " response

    if ! [[ "$response" =~ ^[yY][eE]?[sS]?$ ]]; then
        echo -e "\nInstallation aborted."
        exit 1
    fi
fi

echo -e "\nLinking files."

for SRC in "${!mappings[@]}"; do
    IFS=',' read -ra values <<< ${mappings[$SRC]}
    OS=${values[0]}
    DST=${values[1]}

    mkdir -p "$(dirname "$DST")"
    ln -sf "$dotfiles/$SRC" "$DST"
    echo "... linked $SRC"
done

echo -e "\nLinking completed."
