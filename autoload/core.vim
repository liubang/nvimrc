"======================================================================
"
" core.vim - 
"
" Created by liubang on 2020/08/10
" Last Modified: 2020/08/10 00:32
"
"======================================================================

let s:_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

function! core#_start()
  call pm#_start()
  call s:_load_core_modules()
endfunc

function! s:_load_core_modules() 
  exec 'source ' . s:_dir . '/rc/default.vim'   
  exec 'source ' . s:_dir . '/rc/mapping.vim'
endfunc
