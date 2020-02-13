#!/bin/sh

# set up symlinks
for f in "${BASH_SOURCE[0]}/config/*"; do
	ln -s $f "$HOME/.config/$(basename $f)"
done
ln -s "${BASH_SOURCE[0]}/gitconfig" "$HOME/.gitconfig"
ln -s "${BASH_SOURCE[0]}/xinitrc" "$HOME/.xinitrc"

# set up vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
