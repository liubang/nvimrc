"======================================================================
"
" utils.vim - 
"
" Created by liubang on 2020/01/21
" Last Modified: 2020/01/21 16:36
"
"======================================================================

function! utils#get_nvim_version()
  redir => s | silent! version | redir END
  return 'v' . matchstr(s, 'NVIM v\zs[^\n]*')
endfunc

function! utils#errmsg(msg) 
  redraw | echo '' | redraw
  echohl ErrorMsg | echom a:msg | echohl NONE
endfunc

function! utils#fzf_options(title)
  return "-i --border --layout=reverse 
        \ --no-unicode --prompt='" . a:title . " > ' --algo=v2"
endfunc

function! utils#is_special_buffer()
  return &buftype =~ '\v(terminal|quickfix)' 
        \ || &filetype =~ '\v(help|startify|defx|vista|undotree|SpaceVimPlugManager|git|Mundo|MundoDiff|vim-plug)'
endfunc

function! utils#maybe_special_buffer()
  return &buftype =~ '\v(terminal|quickfix)' 
        \ || &filetype =~ '\v(defx|vista|undotree|SpaceVimPlugManager|git|Mundo|MundoDiff)'
endfunc
