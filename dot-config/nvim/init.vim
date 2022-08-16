" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')

" Color schemes
Plug 'arcticicestudio/nord-vim'
Plug 'altercation/vim-colors-solarized'

Plug 'sonph/onehalf', {'rtp': 'vim'}

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/fzf'

Plug 'derekwyatt/vim-scala'

" Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}

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
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'nvim-lua/plenary.nvim'
Plug 'scalameta/nvim-metals'

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
" NERDTree Plugin Settings
"*****************************************************************************

" Toggle the NERD Tree on and off with ctr-l
nnoremap <C-l> :NERDTreeToggle<CR>
nnoremap <Leader>ll :NERDTreeToggle<CR>
nnoremap <Leader>lh :NERDTreeFind<Cr>

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Make changing the current root node also modifies pwd as well
let g:NERDTreeChDirMode=2

" Ignore .pyc files
let NERDTreeIgnore = ['\.pyc$']

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

""" "*****************************************************************************
""" " coc.nvim Plugin Settings
""" "*****************************************************************************
""" " TextEdit might fail if hidden is not set.
""" set hidden
""" 
""" " Some servers have issues with backup files, see #649.
""" set nobackup
""" set nowritebackup
""" 
""" " Give more space for displaying messages.
""" set cmdheight=2
""" 
""" " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
""" " delays and poor user experience.
""" set updatetime=300
""" 
""" " Don't pass messages to |ins-completion-menu|.
""" set shortmess+=c
""" 
""" " Always show the signcolumn, otherwise it would shift the text each time
""" " diagnostics appear/become resolved.
""" if has("patch-8.1.1564")
"""   " Recently vim can merge signcolumn and number column into one
"""   set signcolumn=number
""" else
"""   set signcolumn=yes
""" endif
""" 
""" " Use tab for trigger completion with characters ahead and navigate.
""" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
""" " other plugin before putting this into your config.
""" inoremap <silent><expr> <TAB>
"""       \ pumvisible() ? "\<C-n>" :
"""       \ <SID>check_back_space() ? "\<TAB>" :
"""       \ coc#refresh()
""" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
""" 
""" function! s:check_back_space() abort
"""   let col = col('.') - 1
"""   return !col || getline('.')[col - 1]  =~# '\s'
""" endfunction
""" 
""" " Use <c-space> to trigger completion.
""" if has('nvim')
"""   inoremap <silent><expr> <c-space> coc#refresh()
""" else
"""   inoremap <silent><expr> <c-@> coc#refresh()
""" endif
""" 
""" " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
""" " position. Coc only does snippet and additional edit on confirm.
""" " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
""" if exists('*complete_info')
"""   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
""" else
"""   inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
""" endif
""" 
""" " Use `[g` and `]g` to navigate diagnostics
""" " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
""" nmap <silent> [g <Plug>(coc-diagnostic-prev)
""" nmap <silent> ]g <Plug>(coc-diagnostic-next)
""" 
""" " GoTo code navigation.
""" nmap <silent> gd <Plug>(coc-definition)
""" nmap <silent> gy <Plug>(coc-type-definition)
""" nmap <silent> gi <Plug>(coc-implementation)
""" nmap <silent> gr <Plug>(coc-references)
""" 
""" " Use K to show documentation in preview window.
""" nnoremap <silent> K :call <SID>show_documentation()<CR>
""" 
""" function! s:show_documentation()
"""   if (index(['vim','help'], &filetype) >= 0)
"""     execute 'h '.expand('<cword>')
"""   else
"""     call CocActionAsync('doHover')
"""   endif
""" endfunction
""" 
""" " Highlight the symbol and its references when holding the cursor.
""" autocmd CursorHold * silent call CocActionAsync('highlight')
""" 
""" " Symbol renaming.
""" nmap <leader>rn <Plug>(coc-rename)
""" 
""" " Formatting selected code.
""" xmap <leader>f  <Plug>(coc-format-selected)
""" nmap <leader>f  <Plug>(coc-format-selected)
""" 
""" augroup mygroup
"""   autocmd!
"""   " Setup formatexpr specified filetype(s).
"""   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"""   " Update signature help on jump placeholder.
"""   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
""" augroup end
""" 
""" " Applying codeAction to the selected region.
""" " Example: `<leader>aap` for current paragraph
""" xmap <leader>a  <Plug>(coc-codeaction-selected)
""" nmap <leader>a  <Plug>(coc-codeaction-selected)
""" 
""" " Remap keys for applying codeAction to the current buffer.
""" nmap <leader>ac  <Plug>(coc-codeaction)
""" " Apply AutoFix to problem on the current line.
""" nmap <leader>qf  <Plug>(coc-fix-current)
""" 
""" " Map function and class text objects
""" " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
""" xmap if <Plug>(coc-funcobj-i)
""" omap if <Plug>(coc-funcobj-i)
""" xmap af <Plug>(coc-funcobj-a)
""" omap af <Plug>(coc-funcobj-a)
""" xmap ic <Plug>(coc-classobj-i)
""" omap ic <Plug>(coc-classobj-i)
""" xmap ac <Plug>(coc-classobj-a)
""" omap ac <Plug>(coc-classobj-a)
""" 
""" " Use CTRL-S for selections ranges.
""" " Requires 'textDocument/selectionRange' support of language server.
""" nmap <silent> <C-s> <Plug>(coc-range-select)
""" xmap <silent> <C-s> <Plug>(coc-range-select)
""" 
""" " Add `:Format` command to format current buffer.
""" command! -nargs=0 Format :call CocAction('format')
""" 
""" " Add `:Fold` command to fold current buffer.
""" command! -nargs=? Fold :call     CocAction('fold', <f-args>)
""" 
""" " Add `:OR` command for organize imports of the current buffer.
""" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
""" 
""" " Add (Neo)Vim's native statusline support.
""" " NOTE: Please see `:h coc-status` for integrations with external plugins that
""" " provide custom statusline: lightline.vim, vim-airline.
""" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
""" 
""" " Mappings for CoCList
""" " Show all diagnostics.
""" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
""" " Manage extensions.
""" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
""" " Show commands.
""" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
""" " Find symbol of current document.
""" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
""" " Search workspace symbols.
""" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
""" " Do default action for next item.
""" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
""" " Do default action for previous item.
""" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
""" " Resume latest coc list.
""" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
""" 
""" " Toggle panel with Tree Views
""" nnoremap <silent> <space>t :<C-u>CocCommand metals.tvp<CR>
""" " Toggle Tree View 'metalsBuild'
""" nnoremap <silent> <space>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
""" " Toggle Tree View 'metalsCompile'
""" nnoremap <silent> <space>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
""" " Reveal current current class (trait or object) in Tree View 'metalsBuild'
""" nnoremap <silent> <space>tf :<C-u>CocCommand metals.revealInTreeView metalsBuild<CR>
""" 
""" """"" above is the standard/default Coc setup for metals

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

"-----------------------------------------------------------------------------
" nvim-lsp Settings
"-----------------------------------------------------------------------------
" If you just use the latest stable version, then setting this isn't necessary
" let g:metals_server_version = '0.9.8+10-334e402e-SNAPSHOT'

" Avoid showing message extra message when using completion
set shortmess+=c

" Ensure autocmd works for Filetype
set shortmess-=F
