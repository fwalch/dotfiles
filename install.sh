#!/usr/bin/env zsh

whence git > /dev/null || {
  echo 'Git not found. Exiting.'
  return 1
}

echo '✱ Checking out submodules'
git submodule update --init

echo '✱ Linking config files'
targets=(chktexrc gdbinit gemrc gitconfig gitignore gvimrc inputrc irbrc lynxrc nvimrc vimrc zshenv zshrc nvim vim)
for target in $targets; do
  ln -nfs $HOME/.dotfiles/$target $HOME/.$target
done

whence vim > /dev/null && {
  echo '✱ Installing VIM bundles'
  vim +PlugUpgrade +PlugUpdate +qall
}

echo '✔ All done!'
if [ ! -f $HOME/.zshrc.local ]; then
  echo 'Create ~/.zshrc.local for system-specific aliases etc.'
fi
if [ ! -f /etc/gitconfig ]; then
  echo 'Create /etc/gitconfig for system-specific git configuration'
fi
