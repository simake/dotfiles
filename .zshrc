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

# Edit line in vim with ctrl-x ctrl-e (useful for multiline)
autoload edit-command-line; zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Hit ctrl-space to expand aliases
globalias() {
    zle _expand_alias
    zle expand-word
}
zle -N globalias
bindkey -M emacs "^ " globalias
bindkey -M viins "^ " globalias

# Environment variables
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'

### Plugin Configuration (pre-loading)

  ## wfxr/forgit
    forgit_log=ggl
    forgit_diff=ggd
    forgit_add=gga
    forgit_reset_head=ggrh
    forgit_ignore=ggi
    forgit_restore=ggcof
    forgit_clean=ggclean
    forgit_stash_show=ggss
  ##

###

# Initialize Antibody and plugins
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

### Plugin Configuration (post-loading)

  ## zsh-users/zsh-history-substring-search
    # Bind UP and DOWN
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
    # Bind k and j for vim
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down
  ##

###

# Misc includes
include() {
  [[ -f "$1" ]] && source "$1"
}

include "$HOME/.functions"
include "$HOME/.aliases"

