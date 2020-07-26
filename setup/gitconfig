#!/usr/bin/env bash

 if [ $# -ne 2 ]; then
     echo "usage: $(basename $0) <name> <email>"
     exit 1
 fi

git config -f ~/.gitconfig.local user.name $1
git config -f ~/.gitconfig.local user.email $2

echo "Git username and email have been set in ~/.gitconfig.local"
