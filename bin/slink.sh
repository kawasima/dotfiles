dotfiles=".zshrc .tmux.conf .gitconfig .emacs.d .xmonad"

for dotfile in $dotfiles
do
    ln -s "$HOME/dotfiles/$dotfile" $HOME
done

