#!/usr/bin/env bash

files=(
    ".bashrc"
    ".bash_profile"
    ".gitconfig"
)

existing_files=""
for f in ${files[@]}; do
    if [ -f $HOME/$f ]; then
        existing_files="$existing_files $HOME/$f"
    fi
done

if [ -n "$existing_files" ]; then
    echo -e "\nThe following files already exist:"
    printf "%s\n" $existing_files
    echo -e "\nThese files will be replaced."
    read -p "Is that okay? [y/N] " response
    case "$response" in 
        [yY][eE][sS]|[yY])
            rm $existing_files
            echo "... files removed"
            ;;
        *)
            echo -e "\nInstallation cancelled.\n"
            return 1
    esac
fi

echo -e "\nLinking files to home directory:"

for f in ${files[@]}; do
    ln -s $f ~/$f
    echo "... linked $f"
done

echo -e "\nInstallation completed.\n"
