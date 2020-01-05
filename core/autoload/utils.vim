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
endfunc

function! utils#wipe_hidden_buffers()
  let tpbl = []
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    silent execute 'bwipeout' buf
  endfor
endfunc

function! utils#sweep_buffers()
  let bufs = range(1, bufnr('$'))
  let hidden = filter(bufs, 'buflisted(v:val) && !bufloaded(v:val)')
  if !empty(hidden)
    execute 'silent bdelete' join(hidden)
  endif
endfunc

function! utils#buffer_empty()
  let l:current = bufnr('%')
  if !getbufvar(l:current, "&modified")
    enew
    silent! execute 'bdelete ' . l:current
  endif
endfunc

" 删除所有未显示且无修改的缓冲区 
function! utils#clean_buffers()
  for bufNr in filter(range(1, bufnr('$')),
        \ 'buflisted(v:val) && !bufloaded(v:val)')
    execute bufNr . 'bdelete'
  endfor
endfunc

function! utils#check_custom_plug(...) abort
  let l:missing = filter(values(g:plugs), '!isdirectory(v:val.dir)')
  if len(l:missing)
    echom 'Some plugins need to install the missing plugins first!'
    PlugInstall --sync | q
  endif
endfunc

" string 
function! utils#string_replace(text, old, new)
  let data = split(a:text, a:old, 1)
  return join(data, a:new)
endfunc

function! utils#string_strip(text)
  return substitute(a:text, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunc

function! utils#close_terminal() abort
  for terminal_bufnr in s:open_terminals_buffers
    if bufexists(terminal_bufnr)
      exe 'silent bd!' . terminal_bufnr
    endif
  endfor
endfunc

" Open file-explorer split with tmux
function! utils#defx_tmux_explorer(context) abort
  if !g:nvg.tmux || empty(s:explorer)
    return
  endif
  let l:target = a:context['targets'][0]
  let l:parent = fnamemodify(l:target, ':h')
  silent execute '!tmux split-window -p 30 -c '.l:parent.' '.s:explorer
endfunc

function! utils#get_vim_version()
  if g:nvg.nvim
    redir => s
    silent! version
    redir END
    return 'neovim ' . matchstr(s, 'NVIM v\zs[^\n]*')
  else 
    return 'vim ' . v:version
  endif
endfunc

function! utils#rename(name, bang) 
  let l:curfile = expand("%:p")
  let l:curpath = expand("%:h") . "/"
  let v:errmsg = ""
  silent! exe "saveas" . a:bang . " " . fnameescape(l:curpath . a:name)
  if v:errmsg =~# '^$\|^E329'
    let l:oldfile = l:curfile
    let l:curfile = expand("%:p")
    if l:curfile !=# l:oldfile && filewritable(l:curfile)
      silent exe "bwipe! " . fnameescape(l:oldfile)
      if delete(l:oldfile)
        echoerr "Could not delete " . l:oldfile
      endif
    endif
  else
    echoerr v:errmsg
  endif
endfunc

function! utils#coder_has(lang)
  return index(g:nvg.coder, a:lang) >= 0
endfunc

function! utils#strip_trailing_whitespace() 
  let _s = @/
  let l = line('.')
  let c = col('.')
  execute '%s/\r$\|\s\+$//e'
  let @/ = _s
  call cursor(l, c)
endfunc
