#!/bin/sh

mkdir $HOME/.config
# set up symlinks
for f in config/*; do
	ln -s $(pwd)/$f $HOME/.config/
done

mkdir $HOME/.local
# set up symlinks
for f in local/*; do
	ln -s $(pwd)/$f $HOME/.local/
done

ln -s $(pwd)/xinitrc $HOME/.xinitrc
ln -s $(pwd)/gitconfig $HOME/.gitconfig
ln -s $(pwd)/clang-format $HOME/.clang-format

# set up vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
