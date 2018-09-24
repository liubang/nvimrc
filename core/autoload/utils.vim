function! utils#err(msg, f)
  echohl ErrorMsg
  echom '[lbvim-core] ' . a:msg . ' on file ' . a:f
  echohl None
endfunction
