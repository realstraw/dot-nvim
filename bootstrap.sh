#!/usr/bin/env bash

project_root="$(cd "`dirname "$0"`"; pwd)"

echo "Installing vim-plug..."
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Creating nvim config directory..."
mkdir -p ~/.config/nvim/

echo "Linking init.vim file..."
init_vim_path="nvim/init.vim"
rm -rf ~/.config/$init_vim_path
ln $project_root/dot-config/$init_vim_path ~/.config/$init_vim_path
