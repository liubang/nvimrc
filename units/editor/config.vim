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
" map <Leader><Leader> <Plug>(easymotion-prefix)
map <Leader>ll <Plug>(easymotion-lineforward)
map <Leader>jj <Plug>(easymotion-j)
map <Leader>kk <Plug>(easymotion-k)
map <Leader>hh <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" map  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)
" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)

" nmap s <Plug>(easymotion-s2)

" Move to word
map  <Leader>ww <Plug>(easymotion-bd-w)
nmap <Leader>ww <Plug>(easymotion-overwin-w)
" }}}

" {{{ vim-buftabline
set hidden
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprev<CR>

let g:buftabline_show = 2
let g:buftabline_numbers = 2

nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)
" }}}

" {{{ tagbar
let g:tagbar_iconchars = ['*', '~']
nmap <F3> :TagbarToggle<CR>
nnoremap <leader>tb :TagbarToggle<CR>
" Jump to Tagbar window if already open
nnoremap <leader>tj :TagbarOpen j<CR>
" Close the Tagbar window if it is open
nnoremap <leader>tc :TagbarClose<CR>
" }}}

" {{{ NERDTree
let g:NERDTreeShowHidden=1
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeDirArrowExpandable = '*'
let g:NERDTreeDirArrowCollapsible = '~'
let g:NERDTreeIgnore=[
    \ '\.py[cd]$', '\~$', '\.swo$', '\.swp$', '\.DS_Store$',
    \ '^\.hg$', '^\.svn$', '\.bzr$',
    \ ]
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <F4> :NERDTreeToggle<CR>
inoremap <F4> <ESC>:NERDTreeToggle<CR>
nnoremap <Leader>ft :NERDTreeToggle<CR>
nnoremap <Leader>fd :NERDTreeFind<CR>
" }}}

" {{{ vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" {{{ indentLine
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#504945'
let g:indentLine_color_tty_light = 7 " (default: 4)
let g:indentLine_color_dark = 1 " (default: 2)
let g:indentLine_char = '|'
let g:indentLine_enabled = 0
" }}}

" {{{ asyncrun
let g:asyncrun_open = 8
" }}}

" {{{ vim-textobj-user
function! CurrentLineA()
  normal! 0
  let head_pos = getpos('.')
  normal! $
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction

function! CurrentLineI()
  normal! ^
  let head_pos = getpos('.')
  normal! g_
  let tail_pos = getpos('.')
  let non_blank_char_exists_p = getline('.')[head_pos[2] - 1] !~# '\s'
  return
  \ non_blank_char_exists_p
  \ ? ['v', head_pos, tail_pos]
  \ : 0
endfunction

call textobj#user#plugin('line', {
\   '-': {
\     'select-a-function': 'CurrentLineA',
\     'select-a': 'al',
\     'select-i-function': 'CurrentLineI',
\     'select-i': 'il',
\   },
\ })

" }}}

" {{{ AsyncRun
nnoremap <Leader>ar :AsyncRun<Space>
" }}}

" {{{ undotree
nnoremap <Leader>ut :MundoToggle<CR>
let g:mundo_width = 40
let g:mundo_preview_height = 30
let g:mundo_right = 1
let g:mundo_tree_statusline = "undo tree"
" }}}
