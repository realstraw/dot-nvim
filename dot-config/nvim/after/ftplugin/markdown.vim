" Highlight #hashtags (e.g. #home, #work) in all markdown buffers.
" Pure Vim built-ins — no plugin dependency. matchadd() is window-local and
" draws over treesitter when given a high priority. Guard with a window-local
" var so re-sourcing this ftplugin doesn't stack duplicate matches.
"
" Generic tags use MarkdownHashtag. Specific tags get their own colors and a
" higher matchadd priority so they win where they overlap the generic match.
highlight default link MarkdownHashtag Special
highlight default MarkdownHashtagWork guifg=#81a1c1 ctermfg=110
highlight default MarkdownHashtagHome guifg=#d08770 ctermfg=173

if !get(w:, 'markdown_hashtag_match', 0)
  call matchadd('MarkdownHashtag', '#\v[A-Za-z][0-9A-Za-z_/-]*', 200)
  call matchadd('MarkdownHashtagWork', '\v#work>', 210)
  call matchadd('MarkdownHashtagHome', '\v#home>', 210)
  let w:markdown_hashtag_match = 1
endif

" Toggle a markdown checkbox on one line. Pure Vim, no plugin dependency:
"   - [ ] foo  <-> - [x] foo   (only touches the checkbox marker)
" Lines without a checkbox are left unchanged. Defined once (script guard).
if !exists('*s:ToggleCheckbox')
  function! s:ToggleCheckbox() abort range
    for l:lnum in range(a:firstline, a:lastline)
      let l:line = getline(l:lnum)
      if l:line =~# '\v^\s*[-*+] \[ \]'
        call setline(l:lnum, substitute(l:line, '\v(^\s*[-*+] )\[ \]', '\1[x]', ''))
      elseif l:line =~# '\v^\s*[-*+] \[[xX]\]'
        call setline(l:lnum, substitute(l:line, '\v(^\s*[-*+] )\[[xX]\]', '\1[ ]', ''))
      endif
    endfor
  endfunction
endif

" ,ll = toggle checkbox. Normal mode acts on the current line; visual mode
" acts on every line in the selection. Buffer-local to markdown.
nnoremap <buffer> <silent> <Leader>ll :call <SID>ToggleCheckbox()<CR>
xnoremap <buffer> <silent> <Leader>ll :call <SID>ToggleCheckbox()<CR>
