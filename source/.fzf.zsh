# Setup fzf
# ---------
if [[ ! "$PATH" == */home/simon/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/simon/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/simon/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/simon/.fzf/shell/key-bindings.zsh"
