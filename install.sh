#!/bin/sh

# set up symlinks
for directory in "${BASH_SOURCE[0]}/config/*"; do
	ln -s $directory "$HOME/.config/$(basename $directory)"
done
ln -s "${BASH_SOURCE[0]}/gitconfig" "$HOME/.gitconfig"

# set up vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
