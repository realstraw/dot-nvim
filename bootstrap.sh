#!/usr/bin/env bash

project_root="$(cd "`dirname "$0"`"; pwd)"

echo "Installing vim-plug..."
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Creating .config directory..."
mkdir -p ~/.config/

echo "Linking nvim directory..."
rm -rf ~/.config/nvim
ln -s $project_root/dot-config/nvim ~/.config/nvim
