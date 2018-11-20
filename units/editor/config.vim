"======================================================================
"
" config.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 10:33:09
"
"======================================================================

"-----------------------------------------------------------------------
" insert before current line
"-----------------------------------------------------------------------
function! s:snip(text)
  call append(line('.') - 1, a:text)
endfunc

"-----------------------------------------------------------------------
" guess comment
"-----------------------------------------------------------------------
function! s:comment()
  let l:ext = expand('%:e')
  if &filetype == 'vim'
    return '"'
  elseif index(['c', 'cpp', 'h', 'hpp', 'hh', 'cc', 'cxx', 'php'], l:ext) >= 0
    return '//'
  elseif index(['m', 'mm', 'java', 'go', 'delphi', 'pascal'], l:ext) >= 0
    return '//'
  elseif index(['coffee', 'as'], l:ext) >= 0
    return '//'
  elseif index(['c', 'cpp', 'rust', 'go', 'javascript', 'php'], &filetype) >= 0
    return '//'
  elseif index(['coffee'], &filetype) >= 0
    return '//'
  elseif index(['sh', 'bash', 'python', 'perl', 'zsh'], $filetype) >= 0
    return '#'
  elseif index(['make', 'ruby', 'text'], $filetype) >= 0
    return '#'
  elseif index(['py', 'sh', 'pl', 'rb'], l:ext) >= 0
    return '#'
  elseif index(['asm', 's'], l:ext) >= 0
    return ';'
  elseif index(['asm'], &filetype) >= 0
    return ';'
  elseif index(['sql', 'lua'], l:ext) >= 0
    return '--'
  elseif index(['basic'], &filetype) >= 0
    return "'"
  endif
  return "#"
endfunc

"-----------------------------------------------------------------------
" comment bar
"-----------------------------------------------------------------------
function! s:comment_bar(repeat, limit)
  let l:comment = s:comment()
  while strlen(l:comment) < a:limit
    let l:comment .= a:repeat
  endwhile
  return l:comment
endfunc

"-----------------------------------------------------------------------
" comment block
"-----------------------------------------------------------------------
function! <SID>snip_comment_block(repeat)
  let l:comment = s:comment()
  let l:complete = s:comment_bar(a:repeat, 71)
  if l:comment == ''
    return 
  endif
  call s:snip('')
  call s:snip(l:complete)
  call s:snip(l:comment . ' ')
  call s:snip(l:complete)
endfunc

"-----------------------------------------------------------------------
" copyright
"-----------------------------------------------------------------------
function! <SID>snip_copyright(author)
  let l:c = s:comment()
  let l:complete = s:comment_bar('=', 71)
  let l:filename = expand("%:t")
  let l:t = strftime("%Y/%m/%d")
  let l:text = []
  if &filetype == 'python'
    let l:text += ['#!/usr/bin/env python']
    let l:text += ['# -*- coding: utf-8 -*-']
  elseif &filetype == 'sh'
    let l:text += ['#!/bin/sh']
  elseif &filetype == 'perl'
    let l:text += ['#!/usr/bin/env perl']
  elseif &filetype == 'bash'
    let l:text += ['#!/bin/bash']
  elseif &filetype == 'zsh'
    let l:text += ['#!/usr/bin/env zsh']
  elseif &filetype == 'php'
    let l:text += ['#!/usr/bin/env php']
  endif

  let l:text += [l:complete]
  let l:text += [l:c]
  let l:text += [l:c . ' ' . l:filename . ' - ']
  let l:text += [l:c]
  let l:text += [l:c . ' Created by ' . a:author . ' on ' . l:t]
  let l:text += [l:c . ' Last Modified: ' . strftime('%Y/%m/%d %H:%M:%S')]
  let l:text += [l:c]
  let l:text += [l:complete]
  call append(0, l:text)
endfunc

command! -bang -nargs=1 LComment
      \ :call <SID>snip_comment_block('<args>')

command! -bang -nargs=0 LCopyRight
      \ :call <SID>snip_copyright('liubang')

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

" {{{ tagbar
let g:tagbar_iconchars = ['*', '~']
nnoremap <F3> :TagbarToggle<CR>
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
let g:asyncrun_open = 10
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml'] 
nnoremap <F10> :call asyncrun#quickfix_toggle(6) <CR>

function! s:def_command()
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
endfunc

autocmd FileType c,cpp call s:def_command()

" }}}

" {{{ undotree
nnoremap <Leader>ut :MundoToggle<CR>
let g:mundo_width = 40
let g:mundo_preview_height = 30
let g:mundo_right = 1
let g:mundo_tree_statusline = "undo tree"
" }}}
