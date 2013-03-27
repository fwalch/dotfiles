# My config files

Contains the following git submodules:
  * oh-my-zsh - ZSH configuration
  * Vundle - VIM plugin management

Original [`badwolf.dircolors`](zsh/custom/badwolf.dircolors) by Jon Bernard.

## Installation

    git clone git://github.com/fwalch/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles && ./install.sh

The install script will check out the git submodules, link the config files
(e.g. ~/.vimrc -> ~/.dotfiles/vimrc) and install the VIM plugins.
