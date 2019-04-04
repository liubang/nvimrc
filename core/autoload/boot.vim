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
  let g:coc_language_servers = {}

  if !has('python3')
    call  utils#err('Please reinstall your vim/nvim with supporting for python3.', 'boot.vim')
  endif

  " core components
  call core#begin()
    CCM 'vim'
    CCM 'theme'
    CCM 'editor'
    "CCM 'completor'
    CCM 'lsp' 
    CCM 'tags'
  call core#end()
endfunction
