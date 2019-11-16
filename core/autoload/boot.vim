"======================================================================
"
" boot.vim - 
"
" Created by liubang on 2018/12/30
" Last Modified: 2018/12/30 22:05:56
"
"======================================================================

scriptencoding utf-8

let s:called = {
  \ 'run': 0
  \ }

function! boot#run() abort
  " 防止重复调用
  if s:called.run != 0
    echo "OK"
    return
  else
    let s:called.run = 1
  endif

  augroup CustGroupCmd
    autocmd!
  augroup end

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

  if g:nvg.os.mac  
    let g:nvg.ccls = {}
    if !empty($CLANG_RESOURCEDIR)
      let g:nvg.ccls.clang_resourcedir = $CLANG_RESOURCEDIR
    else 
      let g:nvg.ccls.clang_resourcedir = "/Library/Developer/CommandLineTools/usr/lib/clang/11.0.0"
    endif

    if !empty($CLANG_ISYSTEM)
      let g:nvg.ccls.clang_isystem = $CLANG_ISYSTEM
    else
      let g:nvg.ccls.clang_isystem = "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1"
    endif

    if !empty($CLANG_INCLUDE)
      let g:nvg.ccls.clang_include = $CLANG_INCLUDE
    else
      let g:nvg.ccls.clang_include = "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/"
    endif
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

  " core components
  call core#begin()
  CCM 'vim'
  CCM 'theme'
  CCM 'editor'
  CCM 'coder'
  CCM 'markdown'
  call core#end()
endfunction
