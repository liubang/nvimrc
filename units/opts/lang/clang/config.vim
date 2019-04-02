"======================================================================
"
" config.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 10:36:17
"
"======================================================================

"----------------------------------------------------------------------
" clang_format
"----------------------------------------------------------------------
function! s:clang_format_key_bind()
  let g:clang_format#detect_style_file = 1
  let g:clang_format#enable_fallback_style = 1
  call utils#map("nnore", "<leader>cf", ":<c-u>ClangFormat<cr>", 1)
  call utils#map("vnore", "<leader>cf", ":ClangFormat<cr>", 1)
  call utils#map("nnore", "<leader>C", ":ClangFormatAutoToggle<cr>", 1)
endfunc

"----------------------------------------------------------------------
" neoinclude
"----------------------------------------------------------------------
function! s:set_neoinclude_exts()
  if !exists('g:neoinclude#exts')
    let g:neoinclude#exts = {}
  endif
  let g:neoinclude#exts.cpp = ['', 'h', 'hpp', 'hxx']
  let g:neoinclude#exts.c = ['', 'h', 'hpp', 'hxx']
endfunc

"----------------------------------------------------------------------
" cpp_enhanced_highlight
"----------------------------------------------------------------------
function! s:setup_cpp_enhanced_highlight()
  let c_no_curly_error=1
endfun

"----------------------------------------------------------------------
" define c,cpp build command
"----------------------------------------------------------------------
function! s:def_cpp_build_command()
  command! -bang -nargs=0 Cmake
        \ :AsyncRun -cwd=<root> cmake .

  command! -bang -nargs=0 Run 
        \ :AsyncRun -cwd=$(VIM_FILEDIR) -raw "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"

  command! -bang -nargs=0 MakeTest
        \ :AsyncRun -cwd=<root> -raw make test

  command! -bang -nargs=? Make
        \ :AsyncRun -cwd=<root> -raw make <args>

  command! -bang -nargs=0 MakeRun
        \ :AsyncRun -cwd=<root> -raw make run

  command! -bang -nargs=0 Build
        \ :AsyncRun -cwd=$(VIM_FILEDIR) -raw gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"

  command! -bang -nargs=? BuildArgs
        \ :AsyncRun -cwd=$(VIM_FILEDIR) -raw gcc <args> "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"
endfunction

"----------------------------------------------------------------------
" events
"----------------------------------------------------------------------
augroup ClangGroup
  autocmd!
  autocmd FileType c,cpp,objc call s:clang_format_key_bind() 
        \| call s:def_cpp_build_command()
        \| call s:set_neoinclude_exts()
        \| call s:setup_cpp_enhanced_highlight()
augroup END


