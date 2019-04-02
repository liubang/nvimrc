"======================================================================
"
" utils.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 13:10:10
"
"======================================================================

" 打印错误信息
function! utils#err(msg, f)
  redraw! | echo | redraw!
  echohl ErrorMsg
  echom '[vim-core] ' . a:msg . ' on file ' . a:f
  echohl None
endfunction

function! utils#wipe_hidden_buffers()
  let tpbl = []
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    silent execute 'bwipeout' buf
  endfor
endfunction

function! utils#sweep_buffers()
  let bufs = range(1, bufnr('$'))
  let hidden = filter(bufs, 'buflisted(v:val) && !bufloaded(v:val)')
  if !empty(hidden)
    execute 'silent bdelete' join(hidden)
  endif
endfunction

function! utils#buffer_empty()
  let l:current = bufnr('%')
  if !getbufvar(l:current, "&modified")
    enew
    silent! execute 'bdelete ' . l:current
  endif
endfunction

" 删除所有未显示且无修改的缓冲区 
function! utils#clean_buffers()
  for bufNr in filter(range(1, bufnr('$')),
        \ 'buflisted(v:val) && !bufloaded(v:val)')
    execute bufNr . 'bdelete'
  endfor
endfunction

function! utils#check_custom_plug(...) abort
  let l:missing = filter(values(g:plugs), '!isdirectory(v:val.dir)')
  if len(l:missing)
    echom 'Some plugins need to install the missing plugins first!'
    PlugInstall --sync | q
  endif
endfunction

" string 
function! utils#string_replace(text, old, new)
  let data = split(a:text, a:old, 1);
  return join(data, a:new)
endfunction

function! utils#string_strip(text)
  return substitute(a:text, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

function! utils#map(mode, lhs, rhs, ...) abort
  let force = a:0 > 0 ? a:1 : 0
  if (empty(maparg(a:lhs, a:mode)) || force)
    silent execute a:mode . 'map <silent><buffer>' a:lhs a:rhs
  endif
endfunction
