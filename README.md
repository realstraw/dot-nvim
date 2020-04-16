# My neovim setup

## Setup

Run `./bootstrap.sh`, which will perform the following steps:

    1. Download vim-plug into the right location
    1. Creating the directory structure for nvim
    1. Linking the configuration file in this repo to the right path

Next launch `nvim` and type `:PlugInstall` to install all the configured
plugins

## Dependencies

    1. fzf (for fuzzy file lookup)
    1. nodejs, yarn, npm (for coc and vim-metals)
