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
  nnoremap <silent><buffer><leader>cf :<c-u>ClangFormat<cr>
  vnoremap <silent><buffer><leader>cf :ClangFormat<cr>
  nnoremap <silent><buffer><leader>C :ClangFormatAutoToggle<cr>
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

  command! -bang -nargs=0 MakeTest
        \ :AsyncRun -cwd=<root> -raw make test

  command! -bang -nargs=? Make
        \ :AsyncRun -cwd=<root> -raw make <args>

  command! -bang -nargs=0 MakeRun
        \ :AsyncRun -cwd=<root> -raw make run
endfunction

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
" events
"----------------------------------------------------------------------
augroup ClangGroup
  autocmd!
  autocmd FileType c,cpp call s:clang_format_key_bind() 
        \| call s:def_cpp_build_command()
        \| call s:setup_cpp_enhanced_highlight()
augroup END


