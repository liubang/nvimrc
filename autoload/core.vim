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

function! core#run() 
  call plug#init()
  exec 'source ' . $RT . '/core/viminit.vim'
  exec 'source ' . $RT . '/core/mapping.vim'
endfunc
