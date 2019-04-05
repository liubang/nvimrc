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
      \ :call <SID>snip_copyright(g:lbvim.author)

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
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', '#3a3a3a'],
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

let g:fzf_commits_log_options = '--graph --color=always
  \ --format="%C(yellow)%h%C(red)%d%C(reset)
  \ - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
else
  let s:sname = expand('<sfile>')
  call utils#err("Please install ripgrep!", s:sname)
endif

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, 'number', 'no')

  let height = float2nr(&lines/2)
  let width = float2nr(&columns - (&columns * 2 / 10))
  "let width = &columns
  let row = float2nr(&lines / 3)
  let col = float2nr((&columns - width) / 3)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height':height,
        \ }
  let win =  nvim_open_win(buf, v:true, opts)
  call setwinvar(win, '&number', 0)
  call setwinvar(win, '&relativenumber', 0)
endfunction

" Files + devicons
function! MyFzf()
  let l:fzf_files_options = ' --preview "rougify {2..-1} | head -'.&lines.'"'

  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink':   function('s:edit_file'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'down':    '40%' ,
        \ 'window': 'call FloatingFZF()'})
endfunction

let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }


"command! -bang -nargs=? -complete=dir Files
"  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" {{{ keybindings
nmap <silent><Leader>? <plug>(fzf-maps-n)
xmap <silent><Leader>? <plug>(fzf-maps-x)
omap <silent><Leader>? <plug>(fzf-maps-o)

" https://github.com/junegunn/fzf/issues/453
nnoremap <silent> <expr> <Leader>ag (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":Ag\<cr>"
nnoremap <silent> <expr> <Leader>Ag (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":Ag\<c-r>\<c-w>\<cr>"
nnoremap <silent> <expr> <Leader>ff (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":call MyFzf()\<cr>"
nnoremap <silent> <expr> <Leader>f? (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":Files ~\<cr>"
nnoremap <silent> <expr> <Leader>bb (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":Buffer\<cr>"
nnoremap <silent> <expr> <Leader>bl (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":BLines\<cr>"
nnoremap <silent> <expr> <Leader>bt (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":BTags\<cr>"
nnoremap <silent> <expr> <Leader>w? (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":Windows\<cr>"
nnoremap <silent> <expr> <Leader>ht (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":Helptags\<cr>"

nnoremap <silent> <expr> <C-p> (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":call MyFzf()\<cr>"
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
let g:Lf_StlColorscheme = 'one'

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

" function! s:leaderf_keymap()
"   nnoremap <silent><F3> :LeaderfFunction!<CR>
"   nnoremap <silent><leader>lf :LeaderfFunction!<CR>
"   nnoremap <silent><leader>lt :LeaderfBufTag!<CR>
" endfunction

" autocmd FileType c,cpp,php,java,javascript,vim,lua,python,go,lisp call s:leaderf_keymap()
" }}}

" {{{ Vista
let g:vista_echo_cursor_strategy = 'floating_win'
let g:vista_icon_indent = ["\u25cb ", "\u25cf "]
let g:vista_echo_cursor = 0

function! s:vista_keymap()
  nnoremap <silent><leader><F3> :Vista!!<CR>
  nnoremap <silent><leader>tl :Vista!!<CR>
endfunction

autocmd FileType c,cpp,php,java,javascript,vim,lua,python,go,lisp call s:vista_keymap()
" }}}

" {{{ Defx
let g:defx_options = "-split=vertical -winwidth=30 -direction=topleft -toggle=1 -resume=1 -show-ignored-files=0 -buffer-name=Defx_tree -root-marker="
nnoremap <silent><expr><F4> ":Defx " . g:defx_options . "\<cr>"
nnoremap <silent><expr><Leader>ft ":Defx " . g:defx_options . "\<cr>"

augroup vfinit
  au!
  autocmd FileType defx call s:defx_init()
  " auto close last defx windows
  autocmd BufEnter * nested if
        \ (!has('vim_starting') && winnr('$') == 1
        \ && &filetype ==# 'defx') |
        \ call s:close_last_vimfiler_windows() | endif
augroup END

" in this function, we should check if shell terminal still exists,
" then close the terminal job before close vimfiler
function! s:close_last_vimfiler_windows() abort
  call SpaceVim#layers#shell#close_terminal()
  q
endfunction

function! s:defx_init()
    call defx#custom#column('filename', {
          \ 'opened_icon': "\u25cb",
          \ 'directory_icon': "\u25cf",
          \ 'root_icon': "+",
          \ })

    setl nonumber
    setl norelativenumber
    setl listchars=

    " Define mappings
    nnoremap <silent><buffer><expr> <CR>
          \ defx#do_action('drop')
    nnoremap <silent><buffer><expr> c
          \ defx#do_action('copy')
    nnoremap <silent><buffer><expr> m
          \ defx#do_action('move')
    nnoremap <silent><buffer><expr> p
          \ defx#do_action('paste')
    nnoremap <silent><buffer><expr> E
          \ defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr> P
          \ defx#do_action('open', 'pedit')
    nnoremap <silent><buffer><expr> o
          \ defx#is_directory() ?
          \ defx#do_action('open_or_close_tree') : defx#do_action('drop')
    nnoremap <silent><buffer><expr> K
          \ defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> N
          \ defx#do_action('new_file')
    nnoremap <silent><buffer><expr> S
          \ defx#do_action('toggle_sort', 'time')
    nnoremap <silent><buffer><expr> d
          \ defx#do_action('remove')
    nnoremap <silent><buffer><expr> r
          \ defx#do_action('rename')
    nnoremap <silent><buffer><expr> !
          \ defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> x
          \ defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> yy
          \ defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .
          \ defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> <Space><Space>
          \ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> *
          \ defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> ~
          \ defx#do_action('cd')
    nnoremap <silent><buffer><expr> h
          \ defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> l
          \ defx#do_action('change_vim_cwd')
    nnoremap <silent><buffer><expr> j
          \ line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k
          \ line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> <C-l>
          \ defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <C-g>
          \ defx#do_action('print')
    nnoremap <silent><buffer><expr> q
          \ defx#do_action('quit')
  endfunction
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

