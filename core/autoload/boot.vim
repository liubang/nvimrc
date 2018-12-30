"======================================================================
"
" boot.vim - 
"
" Created by liubang on 2018/12/30
" Last Modified: 2018/12/30 22:05:56
"
"======================================================================

function! boot#run() abort
  let g:python_host_skip_check=1
  let g:python3_host_skip_check=1
  let g:python3_host_prog = 'python3'

  let g:HAS_PYTHON3 = has('python3')
  if !g:HAS_PYTHON3 
    echohl ErrorMsg
    echom 'Please reinstall your vim/nvim with supporting for python3.'
    echohl None
    finish
  endif

  " core components
  call core#begin()
    CCM 'vim'
    CCM 'theme'
    CCM 'editor'
    CCM 'completor'
    CCM 'tags'
  call core#end()
endfunction
