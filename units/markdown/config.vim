"======================================================================
"
" config.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 10:37:06
"
"======================================================================

function! s:init_key()
  nmap <silent><Leader>tf :TableFormat<CR>
  nmap <silent><Leader>mp :MarkdownPreview<CR>
endfunc

" {{{ vim-markdown
autocmd FileType markdown,md call s:init_key()
" }}}
