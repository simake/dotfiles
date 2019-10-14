#!/usr/bin/env bash

mappings=(
    ".bashrc"               "$HOME/.bashrc"
    ".bash_profile"         "$HOME/.bash_profile"
    ".functions"            "$HOME/.functions"
    ".aliases"              "$HOME/.aliases"
    ".prompt"               "$HOME/.prompt"
    ".gitconfig"            "$HOME/.gitconfig"
    ".spacemacs"            "$HOME/.spacemacs"
    ".vscode.settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
)

existing_files=""
for (( i=1; i<${#mappings[@]}; i+=2 )); do
    dst=${mappings[i]}
    if [ -e "$dst" ]; then
        existing_files="$existing_files $dst"
    fi
done

if [ -n "$existing_files" ]; then
    echo -e "\nThe following files already exist:"
    printf "%s\n" $existing_files
    echo -e "\nThese files will be replaced."
    read -p "Is that okay? [y/N] " response

    if ! [[ "$response" =~ ^[yY][eE]?[sS]?$ ]]; then
        echo -e "\nInstallation cancelled."
        exit 1
    fi
fi

echo -e "\nLinking files to home directory:"

dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo $dotfiles_dir
for (( i=0; i<${#mappings[@]}; i+=2 )); do
    src=${mappings[i]}
    dst=${mappings[i+1]}
    mkdir -p "$(dirname "$dst")"
    ln -sf "$dotfiles_dir/$src" "$dst"
    echo "... linked $src"
done

echo -e "\nInstallation completed."
