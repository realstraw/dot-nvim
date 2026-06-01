setlocal shiftwidth=2
setlocal tabstop=2

set textwidth=99
set colorcolumn=100

setlocal foldmethod=expr
setlocal foldexpr=v:lua.vim.lsp.foldexpr()
setlocal foldlevel=3
