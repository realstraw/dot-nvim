-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Color schemes
  use 'arcticicestudio/nord-vim'
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

  -- nerdtree
  use 'preservim/nerdtree'

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

  use 'itchyny/lightline.vim'

  use 'tpope/vim-fugitive'

  use 'hashivim/vim-terraform'

  use 'mileszs/ack.vim'

end)
