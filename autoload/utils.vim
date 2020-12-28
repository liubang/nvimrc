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

function! utils#is_special_buffer()
  return &buftype =~ '\v(terminal|quickfix)' 
        \ || &filetype =~ '\v(help|startify|defx|NvimTree|vista|undotree|SpaceVimPlugManager|git|Mundo|MundoDiff|vim-plug)'
endfunc

function! utils#maybe_special_buffer()
  return &buftype =~ '\v(terminal|quickfix)' 
        \ || &filetype =~ '\v(defx|vista|undotree|NvimTree|SpaceVimPlugManager|git|Mundo|MundoDiff)'
endfunc
