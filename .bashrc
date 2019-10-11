#!/usr/bin/env bash


#### Styling ####

# default: PS1="\h:\W \u\$ "
export PS1="\[\033[33m\]\u\[\033[m\]@\[\033[33m\]local:\[\033[33;1m\]\w\[\033[m\]\$ "


#### Alias ####

alias ls='ls -GFh'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."


#### Custom keywords ####

# Source: https://stackoverflow.com/questions/273743/using-wget-to-recursively-fetch-a-directory-with-arbitrary-files-in-it
wgetod() {
  if [ $# -ne 1 ]; then
    echo "usage: wgetod [host]"
  else
    NSLASH="$(echo "$1" | perl -pe 's|.*://[^/]+(.*?)/?$|\1|' | grep -o / | wc -l)"
    NCUT=$((NSLASH > 0 ? NSLASH-1 : 0))
    wget -r -nH --user-agent=Mozilla/5.0 --cut-dirs=$NCUT --no-parent --reject="index.html*" "$1"
  fi
}

# Display the weather using wttr.in
# Source: https://gist.github.com/kjbrum/77b7af04191267b053e9
weather() {
  location="$1"
  curl http://wttr.in/$location?lang=sv
}

# Make new directory and cd into it
mkcd() {
  if [ $# -ne 1 ]; then
    echo "usage: mkcd [dir]"
  else
    mkdir $1 && cd $1
  fi
}

# Print public SSH key, generate it if necessary
# Source: https://github.com/sapegin/dotfiles/blob/master/bin/ssh-key
ssh-key() {
  file="$HOME/.ssh/id_rsa.pub"
  if [ ! -f "$file" ]; then
    ssh-keygen -t rsa
  fi
  cat "$file"
}


#### Path, etc. ####

if [ -d "$HOME/bin" ] ; then
  PATH="$PATH:$HOME/bin"
fi

export PATH="/usr/local/miniconda3/bin:$PATH"
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
