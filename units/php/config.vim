"======================================================================
"
" config.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 10:37:19
"
"======================================================================

if !g:lbvim.use_lsp
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
  function! s:php_highlight()
    highlight link phpDocTags phpDefine
    highlight link phpDocParam phpType
  endfunc

  "----------------------------------------------------------------------
  " events
  "----------------------------------------------------------------------
  augroup PhpGroup
    autocmd!
    autocmd FileType php call s:php_highlight() 
          \| call s:config_deoplete_for_php()
    autocmd BufRead *.phpt setlocal ft=php
    autocmd BufRead *.phtml setlocal ft=html
  augroup END
endif
