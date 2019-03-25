"======================================================================
"
" config.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 10:37:19
"
"======================================================================

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
" define php build command 
"----------------------------------------------------------------------
function! s:def_php_build_command()
  command! -bang -nargs=0 Run
        \ :AsyncRun -cwd=$(VIM_FILEDIR) -raw php $(VIM_FILEPATH)

  command! -bang -nargs=0 Build
        \ :AsyncRun -cwd=<root> -raw composer --optimize-autoloader update
endfunction

"----------------------------------------------------------------------
" events
"----------------------------------------------------------------------
augroup PhpGroup
  autocmd!
  autocmd FileType php call s:init() 
        \| call s:config_deoplete_for_php()
        \| call s:def_php_build_command()
  autocmd BufRead *.phpt setlocal ft=php
  autocmd BufRead *.phtml setlocal ft=html
augroup END

