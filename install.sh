#!/bin/sh

# set up symlinks
for f in config/*; do
	ln -s $(pwd)/$f $HOME/.config
done

# set up symlinks
for f in local/*; do
	ln -s $(pwd)/$f $HOME/.local
done

# set up vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
