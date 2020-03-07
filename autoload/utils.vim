"======================================================================
"
" utils.vim - 
"
" Created by liubang on 2020/01/21
" Last Modified: 2020/01/21 16:36
"
"======================================================================

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

function! utils#fzf_options(title)
  return "-i --border --layout=reverse --no-unicode --prompt='" . a:title . " \uf101 ' --algo=v2"
endfunc
