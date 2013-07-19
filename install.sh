#!/usr/bin/env zsh

whence git > /dev/null || {
  echo 'Git not found. Exiting.'
  return 1
}

echo '✱ Checking out submodules'
git submodule update --init

echo '✱ Linking config files'
targets=(chktexrc gdbinit gitconfig gitignore gvimrc inputrc irbrc lynxrc vimrc zshenv zshrc vim)
for target in $targets; do
  ln -nfs $HOME/.dotfiles/$target $HOME/.$target
done

whence vim > /dev/null && {
  echo '✱ Installing VIM bundles'
  vim +BundleInstall! +qall

  echo '✱ Compiling YouCompleteMe'
  cd ~/.vim/bundle/YouCompleteMe
  ycm_log=$HOME/.dotfiles/YouCompleteMe-install.log
  ./install.sh --clang-completer > $ycm_log
  ycm_ret=$?
  [ $ycm_ret -eq 0 ] && rm $ycm_log
  [ $ycm_ret -ne 0 ] && echo "✘ Something went wrong; check $ycm_log for details."
}

echo '✔ All done!'
if [ ! -f $HOME/.zshrc.local ]; then
  echo 'Create ~/.zshrc.local for system-specific aliases etc.'
fi
if [ ! -f /etc/gitconfig ]; then
  echo 'Create /etc/gitconfig for system-specific git configuration'
fi
