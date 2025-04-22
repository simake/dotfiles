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

# Use vi mode
bindkey -v
bindkey -M viins jk vi-cmd-mode
bindkey -M viins kj vi-cmd-mode

bindkey '^?' backward-delete-char
bindkey "^W" backward-kill-word

autoload -Uz select-bracketed
zle -N select-bracketed
for m in visual viopp; do
    for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
        bindkey -M $m $c select-bracketed
    done
done

autoload -Uz select-quoted
zle -N select-quoted
for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
        bindkey -M $m $c select-quoted
    done
done

# TODO: add in the below code without adding delay to commands such as dd and cc
autoload -Uz surround
#zle -N delete-surround surround
#zle -N change-surround surround
zle -N add-surround surround
#bindkey -M vicmd cs change-surround
#bindkey -M vicmd ds delete-surround
#bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround

# Setup autocompletion
autoload -Uz compinit; compinit -C -i
zstyle ':completion::complete:*' use-cache 1

# Configure completion menu
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Edit line in vim with ctrl-x ctrl-x (useful for multiline)
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

  ## *author/package*
    # *config*
  ##

###

# Download Antigen if it's not there yet
if [ ! -f ~/.antigen/antigen.zsh ]; then
    mkdir ~/.antigen
    curl -L git.io/antigen > ~/.antigen/antigen.zsh
fi

# Initialize Antigen and plugins
source ~/.antigen/antigen.zsh

antigen theme romkatv/powerlevel10k

antigen bundle rupa/z
antigen bundle zsh-users/zsh-completions

# Note: order of these is important
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

