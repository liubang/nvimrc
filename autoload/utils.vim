" vim: et ts=2 sts=2 sw=2

function! utils#get_vim_version()
  if has('nvim')
    redir => s
    silent! version
    redir END
    return 'neovim ' . matchstr(s, 'NVIM v\zs[^\n]*')
  else
    return 'vim ' . v:version
  endif
endfunc

function! utils#errmsg(msg) 
  redraw | echo '' | redraw
  echohl ErrorMsg
  echom a:msg
  echohl NONE
endfunc
