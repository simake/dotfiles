#!/usr/bin/env bash

mappings=(
#    ON      SRC                               DST
    "NO"   ".bashrc"                        "$HOME/.bashrc"
    "NO"   ".bash_profile"                  "$HOME/.bash_profile"
    "NO"   ".zshrc"                         "$HOME/.zshrc"
    "NO"   ".functions"                     "$HOME/.functions"
    "NO"   ".aliases"                       "$HOME/.aliases"
    "NO"   ".prompt"                        "$HOME/.prompt"
    "NO"   ".gitconfig"                     "$HOME/.gitconfig"
    "NO"   ".spacemacs"                     "$HOME/.spacemacs"
    "NO"   ".vscode.settings.json"          "$HOME/Library/Application Support/Code/User/settings.json"
    # Note: plists are replaced upon saving, breaking the link
    "NO"   "com.googlecode.iterm2.plist"    "$HOME/Library/Preferences/com.googlecode.iterm2.plist"
)

# Toggle active mappings
while true; do
    echo -e "\nMake selections (type OK when satisfied):"
    for (( i=0; i<${#mappings[@]}; i+=3 )); do
        on=${mappings[i]}
        src=${mappings[i+1]}
        dst=${mappings[i+2]}
        echo -e "$((i/3))) $on  $src  -->  $dst"
    done
    read selections

    if [[ $selections =~ ^[oO][kK]$ ]]; then
        break
    fi

    for selection in ${selections[@]}; do
        if ! [[ $selection =~ ^[0-9]+$ ]]; then
            continue
        fi

        idx=$(($selection * 3))

        if [ $idx -ge ${#mappings[@]} ]; then
            continue
        fi

        if [ ${mappings[idx]} == "YE" ]; then
            mappings[idx]="NO"
        else
            mappings[idx]="YE"
        fi
    done
done

existing_files=""
for (( i=0; i<${#mappings[@]}; i+=3 )); do
    on=${mappings[i]}
    dst=${mappings[i+2]}

    if [ "$on" == "NO" ]; then
        continue
    fi
    
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
        echo -e "\nInstallation aborted."
        exit 1
    fi
fi

echo -e "\nLinking selected files."

dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
for (( i=0; i<${#mappings[@]}; i+=3 )); do
    on=${mappings[i]}
    src=${mappings[i+1]}
    dst=${mappings[i+2]}

    if [ "$on" == "NO" ]; then
        continue
    fi

    mkdir -p "$(dirname "$dst")"
    ln -sf "$dotfiles_dir/$src" "$dst"
    echo "... linked $src"
done

echo -e "\nInstallation completed."
