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
