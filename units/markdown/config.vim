function! s:init_key()
  nmap <Leader> tf: TableFormat<CR>
  nmap <Leader> mp: MarkdownPreview<CR>
endfunc

" {{{ vim-markdown
autocmd FileType markdown,md call s:init_key()
" }}}
