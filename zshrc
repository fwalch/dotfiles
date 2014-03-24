#
# ~/.zshrc
#

export ZSH=$HOME/.dotfiles/zsh/oh-my-zsh
export ZSH_THEME="fwalch"

plugins=(gitfast)

# For virtual console, fall back to fwalch theme included in oh-my-zsh
if [[ $TERM != "linux" ]]; then
  export ZSH_CUSTOM=$HOME/.dotfiles/zsh/custom
fi

source $ZSH/oh-my-zsh.sh

# Colors!
if [[ $TERM != "linux" ]]; then
  eval $(dircolors -b $ZSH_CUSTOM/badwolf.dircolors)
  export GREP_COLOR='01;33'
  # Use LS_COLORS for completion
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

bindkey -v

bindkey -M viins "^K" history-beginning-search-backward
bindkey -M viins "^J" history-beginning-search-forward
bindkey -M viins "^P" up-line-or-history
bindkey -M viins "^N" down-line-or-history

bindkey -M vicmd "^K" history-beginning-search-backward
bindkey -M vicmd "^J" history-beginning-search-forward
bindkey -M vicmd "^P" up-line-or-history
bindkey -M vicmd "^N" down-line-or-history
bindkey -M vicmd "?" history-incremental-search-backward
bindkey -M vicmd "/" history-incremental-search-forward

unsetopt correct_all
unsetopt auto_name_dirs

source $HOME/.zshrc.local
