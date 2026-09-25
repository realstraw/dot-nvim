" Scala highlighting comes from the bundled legacy regex syntax file
" ($VIMRUNTIME/syntax/scala.vim, i.e. derekwyatt/vim-scala), which uses
" `syntax sync minlines=200 maxlines=1000`. When the sync window doesn't
" reach a multi-line interpolated string's opening quote (long strings, or
" incremental redraws while editing), Vim can't tell it's still inside the
" string. The string body then renders as code and interpolations like `$xs`
" lose their highlighting. Always syncing from the top of the file fixes it.
syntax sync fromstart
