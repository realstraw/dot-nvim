lua require('plugins')

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')

Plug 'junegunn/fzf'

" Plug 'derekwyatt/vim-scala'

Plug 'itchyny/lightline.vim'

Plug 'tpope/vim-fugitive'

Plug 'hashivim/vim-terraform'

Plug 'mileszs/ack.vim'

Plug 'jeetsukumaran/vim-buffergator'

Plug 'pangloss/vim-javascript'

Plug 'lervag/vimtex'

" For Markdown editing
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" nvim-cmp
Plug 'neovim/nvim-lspconfig'
" Plug 'hrsh7th/nvim-cmp'
" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-vsnip'
" Plug 'hrsh7th/vim-vsnip'

" Plug 'nvim-lua/plenary.nvim'
" Plug 'scalameta/nvim-metals'

" Initialize plugin system
call plug#end()

color nord
" set background=light
" color solarized

" remap leader key
let mapleader = ","
nnoremap <Leader>, ,

" Set the file to be hard wrapped at 80 chars
set textwidth=79
set colorcolumn=80

" Tabstops are 4 spaces
set tabstop=4
set shiftwidth=4

" Replace tabs with spaces
set expandtab

" show line numbers
set number

" The 'scrolloff' sets there are always at least 10 lines visible above and
" below the cursor
set so=10

" more space for display commands
set cmdheight=2

" Shortcut for removing trailing white spaces
nnoremap <Leader>clr :%s/\s\+$//e<cr>

"*****************************************************************************
" Settings for ctags
"*****************************************************************************
set tags=.tags

" Set the folding option to indent
" nnoremap <space> za
" nnoremap <S-space> zA
set foldmethod=syntax
set foldlevel=3

" Shortcut for no highlight
nnoremap <C-h> :nohls<cr>

" Remap buffer next and previous
nnoremap <Leader>jj :bn<cr>
nnoremap <Leader>kk :bp<cr>

set wildignore+=*.o,*.obj,.git,target,build,*.class,*.cache,*.pyc,_build,node_modules

"*****************************************************************************
" Settings for grep or Ack
"*****************************************************************************
nnoremap <silent> <C-n> :cn<CR>zv
nnoremap <silent> <C-p> :cp<CR>zv

" comment highlighting for jsonc
autocmd FileType json syntax match Comment +\/\/.\+$+

"*****************************************************************************
" Settings for vim-scala
"*****************************************************************************
" Configuration for vim-scala
au BufRead,BufNewFile *.sbt set filetype=scala

"*****************************************************************************
" Settings for FZF
"*****************************************************************************
nnoremap <Leader>oo :FZF<CR>

"*****************************************************************************
" Settings for Telescope
"*****************************************************************************
lua require('telescope_settings')
nnoremap <Leader>ff <cmd>Telescope find_files<cr>
nnoremap <Leader>fg <cmd>Telescope live_grep<cr>
nnoremap <Leader>fb <cmd>Telescope buffers<cr>
nnoremap <Leader>fh <cmd>Telescope help_tags<cr>

" "*****************************************************************************
" " nvim-tree Plugin Settings
" "*****************************************************************************

lua require('nvim_tree_settings')
nnoremap <C-l> :NvimTreeToggle<CR>

" "*****************************************************************************
" " NERDTree Plugin Settings
" "*****************************************************************************
" 
" " Toggle the NERD Tree on and off with ctr-l
" nnoremap <C-l> :NERDTreeToggle<CR>
" nnoremap <Leader>ll :NERDTreeToggle<CR>
" nnoremap <Leader>lh :NERDTreeFind<Cr>
" 
" " Show the bookmarks table on startup
" let NERDTreeShowBookmarks=1
" 
" " Make changing the current root node also modifies pwd as well
" let g:NERDTreeChDirMode=2
" 
" " Ignore .pyc files
" let NERDTreeIgnore = ['\.pyc$']
" 

"*****************************************************************************
" NvimTree Plugin Settings
"*****************************************************************************


"*****************************************************************************
" lightline Plugin Settings
"*****************************************************************************
" Show full path of file instead of just the file name
let g:lightline = {
    \    'active': {
    \        'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ],
    \    },
    \    'colorscheme': 'nord'
    \}

"*****************************************************************************
" nvim-cmp Plugin Settings
"*****************************************************************************
set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- -- Setup lspconfig.
  -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
  --   capabilities = capabilities
  -- }
EOF

""""""""""""""""""""""""
" METALS!!!!!!
""""""""""""""""""""""""

lua require('my_metals_config')

"-----------------------------------------------------------------------------
" nvim-lsp Mappings
"-----------------------------------------------------------------------------
nnoremap <silent> gd          <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K           <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi          <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr          <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gds         <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gws         <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <leader>rn  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>f   <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <leader>ca  <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>ws  <cmd>lua require'metals'.worksheet_hover()<CR>
nnoremap <silent> <leader>aa  <cmd>lua vim.diagnostic.setqflist()<CR>
nnoremap <silent> <space>d    <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> [c          <cmd>lua vim.diagnostic.goto_prev { wrap = false }<CR>
nnoremap <silent> ]c          <cmd>lua vim.diagnostic.goto_next { wrap = false }<CR>
nnoremap <silent> <leader>:   <cmd>lua require("telescope").extensions.metals.commands()<CR>

"-----------------------------------------------------------------------------
" nvim-lsp Settings
"-----------------------------------------------------------------------------
" If you just use the latest stable version, then setting this isn't necessary
" let g:metals_server_version = '0.9.8+10-334e402e-SNAPSHOT'

" Avoid showing message extra message when using completion
set shortmess+=c

" Ensure autocmd works for Filetype
set shortmess-=F
