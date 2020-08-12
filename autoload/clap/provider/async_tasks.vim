" Author: liubang <it.liubang@gmail.com>
" Description: List async tasks.

let s:save_cpo = &cpoptions
set cpoptions&vim

let s:tasks = {}

function! s:tasks.source() abort
  let l:bufnr = bufnr('')
  execute 'keepalt buffer' g:clap.start.bufnr
  let rows = asynctasks#source(&columns * 48 / 100)	
  execute 'keepalt buffer' l:bufnr
  let source = []	
  for row in rows 	
    let source += [row[0]. '  ' . row[1] . '  : ' . row[2]]	
  endfor	
  return source
endfunc

function! s:tasks.sink(item) abort 
  let p1 = stridx(a:item, '<')	
  if p1 <= 0 
    return
  endif
  let name = strpart(a:item, 0, p1)	
  let name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')	
  if name != ''	
    exec "AsyncTask ". fnameescape(name)	
  endif	
endfunc

let g:clap#provider#async_tasks# = s:tasks

let &cpoptions = s:save_cpo
unlet s:save_cpo
