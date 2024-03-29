#!/usr/bin/env bash
set -eo pipefail

# Usage: link.sh [-y] [file1 file2 ...]
# -y skips the prompt for overwriting existing files
# file1 file2 ... limit the linking to the specified files

file_args=("$@")
if [[ "$1" = "-y" ]]; then
    skip_prompt="yes"
    file_args=("${@:2}")
fi

dotfiles="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $dotfiles/link

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
    [".vscode.keybindings.json"]="macos,$HOME/Library/Application Support/Code/User/keybindings.json"
    ["karabiner"]="macos,$HOME/.config/karabiner"
    # Note: plists are replaced upon saving, breaking the link
    ["com.googlecode.iterm2.plist"]="macos,$HOME/Library/Preferences/com.googlecode.iterm2.plist"
)

declare -A mappings

for SRC in * .[^.]*; do
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

# If there are file args, limit the mappings to those files.
if [[ ${#file_args[@]} -gt 0 ]]; then
    for SRC in "${!mappings[@]}"; do
        exists=""
        for arg in "${file_args[@]}"; do
            if [[ $SRC == $arg ]]; then
                exists="yes"
                break
            fi
        done
        if [[ -z $exists ]]; then
            unset mappings[$SRC]
        fi
    done
    if [[ ${#mappings[@]} -ne ${#file_args[@]} ]]; then
        echo "Error: Some specified files not found."
        echo "Specified files: ${file_args[@]}"
        echo "Files found: ${!mappings[@]}"
        exit 1
    fi
fi

existing_destinations=""
for rhs in "${mappings[@]}"; do
    IFS=',' read -ra values <<< "$rhs"
    OS=${values[0]}
    DST=${values[1]}
    if [[ -e $DST ]]; then
        existing_destinations="$existing_destinations;$DST"
    fi
done

if [[ -n "$existing_destinations" && -z "$skip_prompt" ]]; then
    echo -e "\nThe following destinations already exist:"
    ( IFS=';'; printf "%s\n" $existing_destinations )
    echo -e "\nThese files will be replaced. Folders will be moved to (and replace) *.old."
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
    if [[ -d $DST ]]; then
        rm -rf "$DST.old"
        mv "$DST" "$DST.old"
        echo "... moved $DST to *.old"
    fi
    ln -sfn "$dotfiles/link/$SRC" "$DST"
    echo "... linked $SRC"
done

echo -e "\nLinking completed."
