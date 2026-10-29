#!/bin/bash

dotfiles=(.zshrc .tmux.conf .gitconfig
          .Xresources
          .eslintrc
          .emacs.d/init .emacs.d/init.el
          .xmonad/xmobarrc .xmonad/xmonad.hs)

# link <target> <linkpath>: create a symlink unless something already exists there
link() {
    if [ -L "$2" ]; then
        return
    elif [ -e "$2" ]; then
        echo "Skip $2 (exists and is not a symlink)"
    else
        ln -s "$1" "$2"
        echo "Create $2"
    fi
}

for dotfile in "${dotfiles[@]}"
do
    link "$HOME/dotfiles/$dotfile" "$HOME/$dotfile"
done

# Claude Code skills
mkdir -p "$HOME/.claude/skills"
for skill_dir in "$HOME/dotfiles/claude/skills"/*/; do
    [ -d "$skill_dir" ] || continue
    skill_name=$(basename "$skill_dir")
    link "${skill_dir%/}" "$HOME/.claude/skills/$skill_name"
done
