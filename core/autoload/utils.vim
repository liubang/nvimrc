"======================================================================
"
" utils.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 13:10:10
"
"======================================================================

function! utils#err(msg, f)
  echohl ErrorMsg
  echom '[lbvim-core] ' . a:msg . ' on file ' . a:f
  echohl None
endfunction
