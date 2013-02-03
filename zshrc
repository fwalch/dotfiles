export ZSH=$HOME/.dotfiles/zsh/oh-my-zsh
export ZSH_THEME="fwalch"
export ZSH_CUSTOM=$HOME/.dotfiles/zsh/custom

plugins=(git vi-mode git-flow battery)
source $ZSH/oh-my-zsh.sh

# Load local config for custom aliases etc.
source $HOME/.zshrc.local

