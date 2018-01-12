dotfiles=".zshrc .tmux.conf .gitconfig .emacs.d/init .emacs.d/init.el .xmonad/xmobarrc .xmonad/xmonad.hs"

for dotfile in $dotfiles
do
    ln -s "$HOME/dotfiles/$dotfile" $HOME/$dotfile
done

