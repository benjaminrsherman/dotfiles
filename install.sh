#!/bin/sh

rsync -a config "$HOME/.config"
cp gitconfig "$HOME/.gitconfig"

# set up vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
