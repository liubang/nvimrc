let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabCrMapping = 1


" Add spaces after comment delimiters by default
let g:NERDSpaceDelims=1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

nnoremap <C-\/> :NERDComToggleComment<cr>

" easymotion {{{
map <Leader><Leader> <Plug>(easymotion-prefix)
" Consistent with spacemacs
" <Leader>f{char} to move to {char}
map  <Leader>jj <Plug>(easymotion-bd-f)
nmap <Leader>jj <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap <Leader>jJ <Plug>(easymotion-overwin-f2)
" Jump to line
map <Leader>jl <Plug>(easymotion-bd-jk)
nmap <Leader>jl <Plug>(easymotion-overwin-line)
" Jump to word
map  <Leader>jw <Plug>(easymotion-bd-w)
nmap <Leader>jw <Plug>(easymotion-overwin-w)
" }}}