-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Color schemes
  use 'nordtheme/vim'
  use 'altercation/vim-colors-solarized'

  -- scala-metals
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip" },
    }
  }
  use {
    'scalameta/nvim-metals',
    requires = {
      { 'nvim-lua/plenary.nvim' }
    }
  }

  -- lspconfigs
  use 'neovim/nvim-lspconfig'

  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'BurntSushi/ripgrep' }
    }
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
  }

  -- for status bar configurations
  -- use 'itchyny/lightline.vim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true
    },
  }

  use 'tpope/vim-fugitive'

  use 'hashivim/vim-terraform'

  use 'mileszs/ack.vim'

  -- use 'junegunn/fzf'

  use 'jeetsukumaran/vim-buffergator'

  use 'pangloss/vim-javascript'

  use 'lervag/vimtex'

  use {
    'plasticboy/vim-markdown',
    requires = {
      { 'godlygeek/tabular' },
    },
  }

  use 'fatih/vim-go'

  use 'lukas-reineke/indent-blankline.nvim'

end)
