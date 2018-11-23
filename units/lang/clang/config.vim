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
  " map to <Leader>cf in C++ code
  nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
  vnoremap <buffer><Leader>cf :ClangFormat<CR>
  " Toggle auto formatting:
  nmap <Leader>C :ClangFormatAutoToggle<CR>
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
" events
"----------------------------------------------------------------------
augroup ClangGroup
  autocmd!
  autocmd FileType c,cpp,objc call s:clang_format_key_bind()
  autocmd FileType c,cpp,objc call s:set_neoinclude_exts()
  autocmd FileType c,cpp,objc call s:setup_cpp_enhanced_highlight()
augroup END


