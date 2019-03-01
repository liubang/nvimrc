"======================================================================
"
" config.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 10:33:09
"
"======================================================================


"----------------------------------------------------------------------
" get sid 
"----------------------------------------------------------------------
function! s:SID()
  if ! exists('s:sid')
    let s:sid = matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
  endif
  return s:sid
endfunction
let s:SNR = '<SNR>'.s:SID().'_'

"-----------------------------------------------------------------------
" insert before current line
"-----------------------------------------------------------------------
function! s:snip(text)
  call append(line('.') - 1, a:text)
endfunction

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
endfunction

"-----------------------------------------------------------------------
" comment bar
"-----------------------------------------------------------------------
function! s:comment_bar(repeat, limit)
  let l:comment = s:comment()
  while strlen(l:comment) < a:limit
    let l:comment .= a:repeat
  endwhile
  return l:comment
endfunction

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
endfunction

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
endfunction

command! -bang -nargs=1 LComment
      \ :call <SID>snip_comment_block('<args>')

command! -bang -nargs=0 LCopyRight
      \ :call <SID>snip_copyright('liubang')

" {{{ fzf
" Hide statusline of terminal buffer
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" This is the default extra key bindings
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_colors ={ 
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

function! s:plug_help_sink(line)
  let dir = g:plugs[a:line].dir
  for pat in ['doc/*.txt', 'README.md']
    let match = get(split(globpath(dir, pat), "\n"), 0, '')
    if len(match)
      execute 'tabedit' match
      return
    endif
  endfor
  tabnew
  execute 'Explore' dir
endfunction

command! PlugHelp call fzf#run(fzf#wrap({
      \ 'source': sort(keys(g:plugs)),
      \ 'sink':   function('s:plug_help_sink')}))

" {{{ keybindings
nmap <silent><Leader>? <plug>(fzf-maps-n)
xmap <silent><Leader>? <plug>(fzf-maps-x)
omap <silent><Leader>? <plug>(fzf-maps-o)

" https://github.com/junegunn/fzf/issues/453
nnoremap <silent> <expr> <Leader>ag (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '') . ":Ag\<cr>"
nnoremap <silent> <expr> <Leader>Ag (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '') . ":Ag\<c-r>\<c-w>\<cr>"
nnoremap <silent> <expr> <Leader>ff (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '') . ":Files\<cr>"
nnoremap <silent> <expr> <Leader>f? (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '') . ":Files ~\<cr>"
nnoremap <silent> <expr> <Leader>bb (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '') . ":Buffer\<cr>"
nnoremap <silent> <expr> <Leader>bl (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '') . ":BLines\<cr>"
nnoremap <silent> <expr> <Leader>bt (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '') . ":BTags\<cr>"
nnoremap <silent> <expr> <Leader>w? (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '') . ":Windows\<cr>"
nnoremap <silent> <expr> <Leader>ht (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '') . ":Helptags\<cr>"

nnoremap <silent> <expr> <C-p> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '') . ":FZF\<cr>"
" search current word with Ag
" nnoremap <silent> <leader>wc :let @/=expand('<cword>')<cr> :Ag <C-r>/<cr><a-a>
" }}}

"}}}

" {{{ vim_current_word
let g:vim_current_word#enabled = 1
let g:vim_current_word#highlight_twins = 1
let g:vim_current_word#highlight_current_word = 0
let g:vim_current_word#highlight_only_in_focused_window = 1
" }}}

" easymotion {{{
" map <Leader><Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
map <Leader>ll <Plug>(easymotion-lineforward)
map <Leader>jj <Plug>(easymotion-j)
map <Leader>kk <Plug>(easymotion-k)
map <Leader>hh <Plug>(easymotion-linebackward)

" map  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)
" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)

" nmap s <Plug>(easymotion-s2)

" Move to word
map  <Leader>ww <Plug>(easymotion-bd-w)
nmap <Leader>ww <Plug>(easymotion-overwin-w)
" }}}

" {{{ leaderf
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = g:lbvim.cache_dir
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1

let g:Lf_WildIgnore = {
      \ 'dir': ['.svn','.git','.hg'],
      \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
      \ }

let g:Lf_MruFileExclude = ['*.so', '*.exe', '*.py[co]', '*.sw?', '~$*', '*.bak', '*.tmp', '*.dll']
let g:Lf_MruMaxFiles = 2048
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<m-n>'
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

let g:Lf_NormalMap = {
    \ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
    \ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<cr>']],
    \ "Mru": [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<cr>']],
    \ "Tag": [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<cr>']],
    \ "BufTag": [["<ESC>", ':exec g:Lf_py "bufTagExplManager.quit()"<cr>']],
    \ "Function": [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<cr>']],
    \ }

nnoremap <silent><F3> :LeaderfFunction!<CR>
nnoremap <silent><leader>lf :LeaderfFunction!<CR>
nnoremap <silent><leader>lt :LeaderfBufTag!<CR>
" }}}

" {{{ NERDTree
nnoremap <silent><F4> :NERDTreeToggle<CR>
nnoremap <silent><Leader>ft :NERDTreeToggle<CR>
nnoremap <silent><Leader>fd :NERDTreeFind<CR>

function! s:nerdtree_init()
  let g:NERDTreeMinimalUI = 1
  let g:NERDTreeWinSize = 25
  let g:NERDTreeCascadeOpenSingleChildDir = 1
  let g:NERDTreeCascadeSingleChildDir = 0
  let g:NERDTreeShowHidden = 1
  let g:NERDTreeRespectWildIgnore = 0
  let g:NERDTreeQuitOnOpen = 0
  let g:NERDTreeHijackNetrw = 1
  " 删除文件自动删除对应的buffer
  let g:NERDTreeAutoDeleteBuffer = 1
  let g:NERDTreeIgnore = [
        \ '\.git$', '\.github', '\.hg$', '\.svn$', '\.stversions$', '\.pyc$', '\.pyo$', '\.svn$', '\.swp$',
        \ '\.DS_Store$', '\.sass-cache$', '__pycache__$', '\.egg-info$', '\.ropeproject$',
    \ ]
  " close vim if the only window left open is a NERDTree
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
endfunc

" Create a new file or dir in path
function! s:create_in_path(node)
  if a:node.path.isDirectory && ! a:node.isOpen
    call a:node.parent.putCursorHere(0, 0)
  endif
  call NERDTreeAddNode()
endfunction

function! s:yank_path(node)
  let l:path = a:node.path.str()
  call setreg('*', l:path)
  echomsg 'Yank node: '.l:path
endfunction

augroup loadNerdtree
  autocmd!
  autocmd VimEnter * silent! autocmd! FileExplorer
  autocmd BufEnter,BufNew *
              \  if isdirectory(expand('<amatch>'))
              \|   call plug#load('nerdtree')
              \|   call nerdtree#checkForBrowse(expand("<amatch>"))
              \| endif

  autocmd! User nerdtree 
        \  call s:nerdtree_init()
        \| call NERDTreeAddKeyMap({
        \   'key': 'N',
        \   'callback': s:SNR.'create_in_path',
        \   'quickhelpText': 'Create file or dir',
        \   'scope': 'Node' })
        \| call NERDTreeAddKeyMap({
        \   'key': 'yy',
        \   'callback': s:SNR.'yank_path',
        \   'quickhelpText': 'yank current node',
        \   'scope': 'Node' })
augroup END

" }}}

" {{{ vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
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

" Define al to select the current line, and define il to select the current line without indentation:
call textobj#user#plugin('line', {
\   '-': {
\     'select-a-function': 'CurrentLineA',
\     'select-a': 'al',
\     'select-i-function': 'CurrentLineI',
\     'select-i': 'il',
\   },
\ })

" Define aP to select a PHP code with <?php and ?>, and define iP to select a PHP code without <?php and ?>:
call textobj#user#plugin('php', {
\   'code': {
\     'pattern': ['<?php\>', '?>'],
\     'select-a': 'aP',
\     'select-i': 'iP',
\   },
\ })
" }}}

" {{{ AsyncRun
let g:asyncrun_open = 15
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml'] 
nnoremap <F10> :call asyncrun#quickfix_toggle(6) <CR>
nnoremap <Leader>ar :AsyncRun<Space>

" for git
command! -bang -nargs=1 GitCommit
      \ :AsyncRun -cwd=<root> -raw git status && git add . && git commit -m <q-args> && git push origin

nnoremap <Leader>gc :GitCommit<Space>

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
endfunction

"----------------------------------------------------------------------
" define php build command 
"----------------------------------------------------------------------
function! s:def_php_build_command()
  command! -bang -nargs=0 Run
        \ :AsyncRun -cwd=$(VIM_FILEDIR) -raw php $(VIM_FILEPATH)

  command! -bang -nargs=0 Build
        \ :AsyncRun -cwd=<root> -raw composer --optimize-autoloader update
endfunction

augroup RegBuildCmd
  autocmd!
  autocmd FileType c,cpp call s:def_cpp_build_command()
  autocmd FileType php call s:def_php_build_command()
augroup END
" }}}

" {{{ undotree
nnoremap <silent><Leader>ut :MundoToggle<CR>
let g:mundo_width = 40
let g:mundo_preview_height = 30
let g:mundo_right = 1
let g:mundo_tree_statusline = "undo tree"
" }}}

" {{{ vinarise.vim
let g:vinarise_enable_auto_detect = 0
nmap <silent><Leader>hx :Vinarise<CR>
" }}}

