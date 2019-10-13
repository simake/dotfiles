#!/usr/bin/env bash


#### Styling ####

# default: PS1="\h:\W \u\$ "
export PS1="\[\033[33m\]\u\[\033[m\]@\[\033[33m\]local:\[\033[33;1m\]\w\[\033[m\]\$ "


#### Alias ####

source ~/.aliases


#### Path, etc. ####

if [ -d "$HOME/bin" ] ; then
  PATH="$PATH:$HOME/bin"
fi

export PATH="/usr/local/miniconda3/bin:$PATH"
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"


#### Sourcing ####

source ~/.functions
