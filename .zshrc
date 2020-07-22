### Environment Variables

# Set ls colors for BSD and GNU (tweaked for WSL)
# https://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxegedabagacex"
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=34"

# Have fzf use fd instead of the default find
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'

### General Settings

setopt NO_BEEP
setopt GLOB_DOTS

# Use vi mode
set -o vi
bindkey jk vi-cmd-mode
bindkey kj vi-cmd-mode

# Setup autocompletion
autoload -Uz compinit; compinit -C -i
zstyle ':completion::complete:*' use-cache 1

# Configure completion menu
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Edit line in vim with ctrl-x ctrl-e (useful for multiline)
autoload edit-command-line; zle -N edit-command-line
bindkey '^x^x' edit-command-line

# Hit ctrl-space to expand aliases
globalias() {
    zle _expand_alias
    zle expand-word
}
zle -N globalias
bindkey -M emacs "^ " globalias
bindkey -M viins "^ " globalias

### Plugins

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
    # Disable horrific red background when nothing is found
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=none
  ##

###

### Sourcing
source_if_exists() {
  [[ -f "$1" ]] && source "$1"
}
source_if_exists "$HOME/.functions"
source_if_exists "$HOME/.aliases"
source_if_exists "$HOME/.fzf.zsh"
# Allow for per-machine overrides of settings
source_if_exists "$HOME/.zshrc.local"

