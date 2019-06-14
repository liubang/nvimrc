"======================================================================
"
" boot.vim - 
"
" Created by liubang on 2018/12/30
" Last Modified: 2018/12/30 22:05:56
"
"======================================================================

if !exists('g:lbvim.use_lsp')
  let g:lbvim.use_lsp = 1
endif

augroup CustGroupCmd
  autocmd!
augroup end

function! boot#run() abort
  if !empty($PYTHON_HOST_PROG)
    let g:python_host_skip_check=1
    let g:python_host_prog  = $PYTHON_HOST_PROG
  endif

  if !empty($PYTHON3_HOST_PROG)
    let g:python3_host_skip_check=1
    let g:python3_host_prog = $PYTHON3_HOST_PROG
  endif

  if !has('python3')
    call  utils#err('Please reinstall your vim/nvim with supporting for python3.', 'boot.vim')
  endif

  if !empty($CFLAGS)
    let g:lbvim.build.cflags = $CFLAGS
  else
    let g:lbvim.build.cflags = "-std=c99 -Wall -O2"
  endif

  if !empty($CPPFLAGS)
    let g:lbvim.build.cppflags = $CPPFLAGS
  else
    let g:lbvim.build.cppflags = "-std=c++11 -Wall -O2"
  endif

  " core components
  call core#begin()

  CCM 'vim'
  CCM 'theme'
  CCM 'editor'
  CCM 'tools'
  CCM 'lsp' 
  CCM 'clang'
  CCM 'markdown'

  call core#end()
endfunction
