"======================================================================
"
" config.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 10:37:06
"
"======================================================================

function! s:init_key()
  nmap <silent><Leader>mp :MarkdownPreview<CR>
  " https://github.com/rstacruz/cheatsheets/blob/master/vim-easyalign.md#easyalign--markdown-tables
  vmap <silent><Leader>ta :EasyAlign *\|<CR>
endfunc

" {{{ vim-markdown
autocmd FileType markdown,md call s:init_key()
" }}}
