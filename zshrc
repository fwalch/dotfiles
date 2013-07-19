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
unsetopt correct_all

source $HOME/.zshrc.local
