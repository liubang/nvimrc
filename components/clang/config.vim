" {{{ clang-format
let g:clang_format#detect_style_file = 1
" vim-clang-format does nothing when .clang-format is not found.
let g:clang_format#enable_fallback_style = 0
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>
" }}}

if !exists('g:neoinclude#exts')
  let g:neoinclude#exts = {}
endif
let g:neoinclude#exts.cpp = ['', 'h', 'hpp', 'hxx']
let g:neoinclude#exts.c = ['', 'h', 'hpp', 'hxx']

