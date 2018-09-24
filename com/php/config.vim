"----------------------------------------------------------------------
"  deoplete for php
"----------------------------------------------------------------------
function! s:config_deoplete_for_php()
  let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
  let g:deoplete#ignore_sources.php = ['omni']
endfunc

"----------------------------------------------------------------------
" init
"----------------------------------------------------------------------
function! s:init()
  highlight link phpDocTags phpDefine
  highlight link phpDocParam phpType
endfunc

"----------------------------------------------------------------------
" events
"----------------------------------------------------------------------
augroup PhpGroup
  autocmd!
  autocmd FileType php call s:init()
  autocmd FileType php call s:config_deoplete_for_php()
  autocmd BufRead *.phpt setlocal ft=php
  autocmd BufRead *.phtml setlocal ft=html
augroup END

