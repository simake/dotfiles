# Initialize Antibody and plugins
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

# Use vi mode
set -o vi
bindkey jk vi-cmd-mode
bindkey kj vi-cmd-mode

# Setup autocompletion
autoload -Uz compinit; compinit -C -i
zstyle ':completion::complete:*' use-cache 1

zstyle ':completion:*' menu select
#zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

setopt NO_BEEP
setopt GLOB_DOTS

# Edit line in vim with ctrl-e (useful for multiline):
autoload edit-command-line; zle -N edit-command-line
bindkey '^x^e' edit-command-line

### Plugin Configuration

  ## zsh-users/zsh-history-substring-search
    # Bind UP and DOWN
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
    # Bind k and j for vim
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down
  ##

###

include() {
  [[ -f "$1" ]] && source "$1"
}

include "$HOME/.functions"
include "$HOME/.aliases"

