"======================================================================
"
" boot.vim - 
"
" Created by liubang on 2018/12/30
" Last Modified: 2018/12/30 22:05:56
"
"======================================================================
scriptencoding utf-8

if !empty($PYTHON_HOST_PROG)
  let g:python_host_skip_check=1
  let g:python_host_prog  = $PYTHON_HOST_PROG
endif
if !empty($PYTHON3_HOST_PROG)
  let g:python3_host_skip_check=1
  let g:python3_host_prog = $PYTHON3_HOST_PROG
endif

if !empty($CFLAGS)
  let g:nvg.build.cflags = $CFLAGS
else
  let g:nvg.build.cflags = "-std=c11 -g -Wall"
endif
if !empty($CPPFLAGS)
  let g:nvg.build.cppflags = $CPPFLAGS
else
  let g:nvg.build.cppflags = "-std=c++14 -g -Wall"
endif

if g:nvg.os.mac  
  let g:nvg.ccls = {}
  if !empty($CLANG_RESOURCEDIR)
    let g:nvg.ccls.clang_resourcedir = $CLANG_RESOURCEDIR
  endif
  if !empty($CLANG_ISYSTEM)
    let g:nvg.ccls.clang_isystem = $CLANG_ISYSTEM
  endif
  if !empty($CLANG_INCLUDE)
    let g:nvg.ccls.clang_include = $CLANG_INCLUDE
  endif
endif

function! boot#run() abort
  call core#begin()
  CCM 'init'
  CCM 'tools'
  CCM 'ui'
  CCM 'coder'
  call core#end()
endfunc
