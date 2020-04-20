#!/bin/sh

# set up symlinks
for f in config/*; do
	ln -s $f $HOME/.config
done

ln -s spacemacs $HOME/.spacemacs

# set up vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
