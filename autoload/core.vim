"======================================================================
"
" core.vim - 
"
" Created by liubang on 2020/05/17
" Last Modified: 2020/05/17 16:59
"
"======================================================================

let $ROOT = g:nvg_root
let $PLUGINS = g:nvg_root . '/plugins'
function! s:load_module()
  let l:modules= get(g:, 'nvg_modules', [])
  for l:item in l:modules
    exec 'source ' . g:nvg_root. '/units/' . l:item . '.vim'
  endfor
endfunc

function! core#run() 
  call plug#init()
  call s:load_module()
endfunc
