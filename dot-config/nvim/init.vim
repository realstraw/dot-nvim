lua require('plugins')

set termguicolors
color nord


if !has("gui_running")
    " make use of the terminal background
    " (https://www.reddit.com/r/neovim/comments/3v06lo/making_the_background_transparent/)
    highlight Normal guibg=none
    highlight NonText guibg=none
endif


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

"-----------------------------------------------------------------------------
" omni complete Settings
"-----------------------------------------------------------------------------
inoremap <Tab> <C-x><C-o>

"*****************************************************************************
" Shortcut for fake-zoom (maximize the window by creating a new tab)
"*****************************************************************************
nnoremap <Leader>wo :tab split<CR>

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

set wildmode=longest:full,full
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
" Settings for Telescope
"*****************************************************************************
lua require('telescope_settings')
nnoremap <Leader>ff <cmd>Telescope find_files<cr>
nnoremap <Leader>,f <cmd>Telescope find_files<cr>
nnoremap <Leader>fg <cmd>Telescope live_grep<cr>
nnoremap <Leader>,g <cmd>Telescope live_grep<cr>
nnoremap <Leader>fb <cmd>Telescope buffers<cr>
nnoremap <Leader>,b <cmd>Telescope buffers<cr>
nnoremap <Leader>fh <cmd>Telescope help_tags<cr>
nnoremap <Leader>,h <cmd>Telescope help_tags<cr>

" "*****************************************************************************
" " nvim-tree Plugin Settings
" "*****************************************************************************

lua require('nvim_tree_settings')
nnoremap <C-l> :NvimTreeToggle<CR>

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
" lualine Plugin Settings
"*****************************************************************************
lua require('lualine_settings')

"*****************************************************************************
" nvim-cmp Plugin Settings
"*****************************************************************************
set completeopt=menu,menuone,noselect

lua require('nvim_cmp_settings')

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
nnoremap <silent> <leader>fm  <cmd>lua vim.lsp.buf.format { async = true }<CR>
nnoremap <silent> <leader>ca  <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>ws  <cmd>lua require'metals'.worksheet_hover()<CR>
nnoremap <silent> <leader>aa  <cmd>lua vim.diagnostic.setqflist()<CR>
nnoremap <silent> <space>d    <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> [c          <cmd>lua vim.diagnostic.goto_prev { wrap = false }<CR>
nnoremap <silent> ]c          <cmd>lua vim.diagnostic.goto_next { wrap = false }<CR>
nnoremap <silent> <leader>mm  <cmd>lua require("telescope").extensions.metals.commands()<CR>

"-----------------------------------------------------------------------------
" nvim-lsp Settings
"-----------------------------------------------------------------------------
" If you just use the latest stable version, then setting this isn't necessary
" let g:metals_server_version = '0.9.8+10-334e402e-SNAPSHOT'

" Avoid showing message extra message when using completion
set shortmess+=c

" Ensure autocmd works for Filetype
set shortmess-=F

"-----------------------------------------------------------------------------
" vim-go Mappings
"-----------------------------------------------------------------------------
nnoremap <silent> gr :GoReferrers<CR>
