"======================================================================
"
" core.vim - 
"
" Created by liubang on 2020/05/17
" Last Modified: 2020/05/17 16:59
"
"======================================================================


let $RT = g:nvg_root
let $MD = g:nvg_root . '/modules'

let s:core_module = [
  \ 'viminit',
  \ 'mapping'
  \ ]

function! s:load_core()
  for m in s:core_module 
    exec 'source ' . $RT . '/core/' . m . '.vim'
  endfor
endfunc

function! core#run() 
  call plug#init()
  call s:load_core()
endfunc
