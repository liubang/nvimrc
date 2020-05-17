"======================================================================
"
" asynctask.vim - 
"
" Created by liubang on 2020/05/17
" Last Modified: 2020/05/17 19:34
"
"======================================================================

let g:asynctasks_term_pos = 'right'
let g:asynctasks_term_reuse = 0

function! s:asynctask_run(item)
  let p1 = stridx(a:item, '<')
  if p1 > 0 
    let name = strpart(a:item, 0, p1)
    let name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')
    if name != ''
      exec "AsyncTask ". fnameescape(name)
    endif
  endif
endfunc

function! s:fzf_tasks_list() 
  let rows = asynctasks#source(&columns * 48 / 100)
  let source = []
  for row in rows 
    let source += [row[0]. '  ' . row[1] . '  : ' . row[2]]
  endfor
  call fzf#run({
    \ 'source': source,
    \ 'sink': function('s:asynctask_run'),
    \ 'options': utils#fzf_options('TaskList'),
    \ 'down': '20%',
    \ })
endfunc

command! -bang -nargs=0 TaskList call MenuHelp_TaskList()
command! -bang -nargs=0 TaskListFzf call s:fzf_tasks_list()
