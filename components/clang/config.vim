" {{{ clang-format
let g:clang_format#detect_style_file = 1
let g:clang_format#enable_fallback_style = 1
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>
" }}}

if !exists('g:neoinclude#exts')
  let g:neoinclude#exts = {}
endif
let g:neoinclude#exts.cpp = ['', 'h', 'hpp', 'hxx']
let g:neoinclude#exts.c = ['', 'h', 'hpp', 'hxx']

" {{{ LanguageClient-neovim
" let g:LanguageClient_serverCommands = {
"     \ 'cpp': ['cquery', '--log-file=/tmp/cq.log'],
"     \ 'c': ['cquery', '--log-file=/tmp/cq.log'],
"     \ }

" let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
" let g:LanguageClient_settingsPath = g:lbvim_home . 'config.json'
" set completefunc=LanguageClient#complete
" set formatexpr=LanguageClient_textDocument_rangeFormatting()

" nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
" nnoremap <silent> gs :call LanguageClient#textDocument_documentSymbol()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
" }}}
