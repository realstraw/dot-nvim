#!/usr/bin/env bash

project_root="$(cd "`dirname "$0"`"; pwd)"

echo "Creating .config directory..."
mkdir -p ~/.config/

echo "Linking nvim directory..."
rm -rf ~/.config/nvim
ln -s $project_root/dot-config/nvim ~/.config/nvim

# echo "Installing vim-plug for vim..."
# curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# 
# echo "Installing packer.nvim for vim..."
# rm -rf ~/.local/share/nvim/site/pack/packer/start/packer.nvim
# git clone --depth 1 https://github.com/wbthomason/packer.nvim\
#      ~/.local/share/nvim/site/pack/packer/start/packer.nvim

echo "Linking .vimrc file..."
rm ~/.vimrc
ln $project_root/dot_vimrc ~/.vimrc
