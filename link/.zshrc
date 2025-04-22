### Environment Variables

export DOTFILES=~/dotfiles

# Set ls colors for BSD and GNU (tweaked for WSL)
# https://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxegedabagacex"
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=34"

# Have fzf use fd instead of the default find
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'

### General Settings

setopt NO_BEEP
setopt GLOB_DOTS

# Make history persistent between sessions

setopt extended_history   # include timestamps in history file
setopt append_history     # shell instances append local history on exit
setopt hist_ignore_dups   # only store one history entry for consecutive duplicate commands
setopt hist_ignore_space  # ignore commands that start with space
export SAVEHIST=100000
export HISTSIZE=100000
export HISTFILE="$HOME/.zsh_history"

# Setup autocompletion
autoload -Uz compinit; compinit -C -i
zstyle ':completion::complete:*' use-cache 1

# Configure completion menu
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

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

  ## jeffreytse/zsh-vi-mode
    # Workaround for jk and kj: https://github.com/jeffreytse/zsh-vi-mode/issues/79
    # Default escape key <ESC> for insert mode
    ZVM_VI_INSERT_ESCAPE_BINDKEY='^['
    # The plugin will auto execute this zvm_after_init function
    function zvm_after_init() {
      zvm_bindkey viins 'jk' zvm_exit_insert_mode
      zvm_bindkey viins 'kj' zvm_exit_insert_mode
    }
  ##

###

# Download Antigen if it's not there yet
if [ ! -f ~/.antigen/antigen.zsh ]; then
    mkdir ~/.antigen
    curl -L git.io/antigen > ~/.antigen/antigen.zsh
fi

# Initialize Antigen and plugins
source ~/.antigen/antigen.zsh

antigen bundle jeffreytse/zsh-vi-mode
antigen bundle rupa/z
antigen bundle zsh-users/zsh-completions
antigen bundle zdharma-continuum/fast-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

antigen apply

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

# Create black hole for loose binaries
[ ! -d $HOME/bin ] && mkdir $HOME/bin
export PATH=$HOME/bin:$PATH

### Sourcing
source_if_exists() {
  [[ -f "$1" ]] && source "$1"
}

for f in $DOTFILES/source/*; do
    source "$f"
done

# Allow for per-machine overrides of settings
source_if_exists "$HOME/.zshrc.local"

