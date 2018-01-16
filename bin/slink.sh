#!/bin/sh

dotfiles=(.zshrc .tmux.conf .gitconfig
          .Xresources
          .eslintrc
          .emacs.d/init .emacs.d/init.el
          .xmonad/xmobarrc .xmonad/xmonad.hs)

for dotfile in ${dotfiles[@]}
do
    echo $dotfile
    if [ ! -L $HOME/$dotfile ]; then
        ln -s "$HOME/dotfiles/$dotfile" $HOME/$dotfile
        echo "Create $dotfile"
    fi
done
