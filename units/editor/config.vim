"======================================================================
"
" config.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 10:33:09
"
"======================================================================

let s:current_file = expand('<sfile>:p')

" {{{ comment
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

command! -bang -nargs=1 Comment
      \ :call <SID>snip_comment_block('<args>')

command! -bang -nargs=0 CopyRight
      \ :call <SID>snip_copyright(g:nvg.author)

" }}}

" {{{ fzf
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

if exists('*nvim_open_win')
  let $FZF_DEFAULT_OPTS = '--layout=reverse'
  let g:fzf_layout = { 'window': 'call win#floating()' }
endif

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
else
  let s:sname = expand('<sfile>')
  call utils#err("Please install ripgrep!", s:sname)
endif

function! s:files()
  let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
  " for performance
  if len(l:files) > 1000
    return l:files
  else
    return s:prepend_icon(l:files)
  endif
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

" Files + devicons
function! s:fzf()
  let l:fzf_files_options = ''
  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink': function('s:edit_file'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'window': 'call win#floating()'})
endfunction

nmap <silent><Leader>? <plug>(fzf-maps-n)
xmap <silent><Leader>? <plug>(fzf-maps-x)
omap <silent><Leader>? <plug>(fzf-maps-o)

" https://github.com/junegunn/fzf/issues/453
nnoremap <silent> <expr> <Leader>ag (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":Rg\<cr>"
nnoremap <silent> <expr> <Leader>bb (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":Buffer\<cr>"
nnoremap <silent> <expr> <Leader>w? (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":Windows\<cr>"
nnoremap <silent> <expr> <Leader>f? (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":Files ~\<cr>"
nnoremap <silent> <expr> <Leader>ht (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":Helptags\<cr>"
nnoremap <silent> <expr> <C-p>      (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":call <sid>fzf()\<cr>"
" }}}

" {{{ vim_current_word
let g:vim_current_word#enabled = 1
let g:vim_current_word#highlight_twins = 1
let g:vim_current_word#highlight_current_word = 0
let g:vim_current_word#highlight_only_in_focused_window = 1
autocmd FileType defx :let b:vim_current_word_disabled_in_this_buffer = 1
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

" {{{ Vista
let g:vista#renderer#enable_icon = 1
let g:vista_default_executive = 'coc'
let g:vista_icon_indent = [" ", " "]
let g:vista_echo_cursor = 0
" let g:vista_echo_cursor_strategy = 'floating_win'
let g:vista_fzf_preview = ['right:50%']
let g:vista_executive_for = {
  \ 'markdown': 'toc'
  \ }

" tab list
nnoremap <silent><leader><F3> :Vista!!<CR>
nnoremap <silent><leader>tl :Vista!!<CR>
nnoremap <silent><leader>vf :Vista finder coc<CR>
" }}}

" {{{ Defx
let g:defx_icons_enable_syntax_highlight = 1
call defx#custom#option('_', {
      \ 'columns': 'indent:git:icons:filename',
      \ 'winwidth': 30,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 0,
      \ 'buffer_name': 'Defx_tree',
      \ 'toggle': 1,
      \ 'resume': 1
      \ })

call defx#custom#column('filename', {
      \ 'min_width': 80,
      \ 'max_width': 80,
      \ })

function! s:defx_context_menu() abort
  let l:actions = ['new_multiple_files', 'rename', 'copy', 'move', 'paste', 'remove']
  let l:selection = confirm('Action?', "&New file/directory\n&Rename\n&Copy\n&Move\n&Paste\n&Delete")
  silent exe 'redraw'
  return feedkeys(defx#do_action(l:actions[l:selection - 1]))
endfunction

function s:defx_toggle_tree() abort
  if defx#is_directory()
    return defx#do_action('open_or_close_tree')
  endif
  return defx#do_action('drop')
endfunction

function! s:defx_mappings()
  setlocal nolist
  setlocal nonumber
  setlocal norelativenumber
  setlocal nofoldenable
  setlocal foldmethod=manual
  nnoremap <silent><buffer>m :call <sid>defx_context_menu()<CR>
  nnoremap <silent><buffer><expr> o <sid>defx_toggle_tree()
  nnoremap <silent><buffer><expr> O defx#do_action('open_tree_recursive')
  " split open
  nnoremap <silent><buffer><expr> s defx#do_action('open', 'botright split')
  " vsplit open 
  nnoremap <silent><buffer><expr> v defx#do_action('open', 'botright vsplit')
  " refresh
  nnoremap <silent><buffer><expr> R defx#do_action('redraw')
  " cd top one 
  nnoremap <silent><buffer><expr> U defx#async_action('multi', [['cd', '..'], 'change_vim_cwd'])
  " if is directory, then cd
  nnoremap <silent><buffer><expr> C defx#is_directory() ? defx#do_action('multi', ['open', 'change_vim_cwd']) : ''
  " cd ~/
  nnoremap <silent><buffer><expr> ~ defx#async_action('cd')
  " toggle ignore files
  nnoremap <silent><buffer><expr> H defx#do_action('toggle_ignored_files')
  " toggle select
  nnoremap <silent><buffer><expr> <C-k> defx#do_action('toggle_select') . 'k'
  nnoremap <silent><buffer><expr> <C-j> defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> <C-a> defx#do_action('toggle_select_all')
  " move up or down
  nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
  " copy path
  nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
  " quit
  nnoremap <silent><buffer><expr> q defx#do_action('quit')
endfunction

augroup vfinit
  au!
  " Close defx if it's the only buffer left in the window
  autocmd FileType defx call s:defx_mappings()                                  "Defx mappings
  " Move focus to the next window if current buffer is defx
  autocmd TabLeave * if &ft == 'defx' | wincmd w | endif
  " Close defx if it's the only buffer left in the window
  autocmd WinEnter * if &ft == 'defx' && winnr('$') == 1 | q | endif
augroup END


nnoremap <silent><Leader>ft :Defx <CR>
" nnoremap <silent><Leader>ft :CocCommand explorer<CR>
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
let g:asyncrun_bell = 1
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml'] 
nnoremap <Leader>ar :AsyncRun<Space>

" for git
command! -bang -nargs=1 GitCommit
      \ :AsyncRun -cwd=<root> -raw git status && git add . && git commit -m <q-args> && git push origin

nnoremap <Leader>gc :GitCommit<Space>

function! s:async_build(args)
  if &filetype == 'c'
    if empty(a:args)
      execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw cc " . g:nvg.build.cflags . " $(VIM_FILEPATH) -o $(VIM_FILEDIR)/$(VIM_FILENOEXT)"
    else
      execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw cc " . a:args . " $(VIM_FILEPATH) -o $(VIM_FILEDIR)/$(VIM_FILENOEXT)"
    endif
  elseif &filetype == 'cpp'
    if empty(a:args)
      execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw c++ " . g:nvg.build.cppflags . " $(VIM_FILEPATH) -o $(VIM_FILEDIR)/$(VIM_FILENOEXT)"
    else
      execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw c++ " . a:args . " $(VIM_FILEPATH) -o $(VIM_FILEDIR)/$(VIM_FILENOEXT)"
    endif
  elseif &filetype == 'java'
    if empty(a:args)
      execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw javac ${VIM_FILEPATH}"
    else
      execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw javac " . a:args . " $(VIM_FILEPATH)"
    endif
  elseif &filetype == 'go'
    execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw go build " . a:args
  endif
endfunction

function! s:async_run(args)
  if &filetype == 'c' || &filetype == 'cpp'
    execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw $(VIM_FILEDIR)/$(VIM_FILENOEXT) " . a:args
  elseif &filetype == 'php'
    if !executable('php')
      call utils#err("php is not executable", s:current_file) 
    else
      execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw php -f $(VIM_FILEPATH) " . a:args
    endif
  elseif &filetype == 'python'
    if !executable('python')
      call utils#err("python is not executable", s:current_file)
    else
      execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw python $(VIM_FILEPATH) " . a:args 
    endif
  elseif &filetype == 'java'
    execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw java $(VIM_FILENOEXT)"
  elseif &filetype == 'sh'
    execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw sh $(VIM_FILEPATH) " . a:args
  elseif &filetype == 'go'
    execute "AsyncRun -cwd=$(VIM_FILEDIR) -raw go run $(VIM_FILEPATH) " . a:args
  endif
endfunction

function! s:maven(opt, goal)
  if executable('mvn')
    execute "AsyncRun -cwd=<root> -raw mvn " . a:opt . " " . a:goal
  else
    call utils#err("mvn is not executable", s:current_file)
  endif
endfunction

command! -bang -nargs=? Build call s:async_build(<q-args>)
command! -bang -nargs=? Run call s:async_run(<q-args>)
command! -bang -nargs=? Maven call s:maven(<q-args>, "")
command! -bang -nargs=? MavenSkip call s:maven("-Dmaven.test.skip", <q-args>)
command! -bang -nargs=? MavenBuildModule call s:maven("-Dmaven.test.skip -am -pl", <q-args>)
cabbrev build <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "Build" : "build"<CR>
cabbrev run <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "Run" : "run"<CR>
nmap <silent> <C-B> :Build<CR>
nmap <silent> <C-R> :Run<CR>
" }}}

" {{{ vinarise.vim
let g:vinarise_enable_auto_detect = 0
nmap <silent><Leader>hx :Vinarise<CR>
" }}}

" {{{ vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)
" }}}

" {{{ vim-easygit
let g:easygit_enable_command = 1
" }}}

" rename  {{{
function! SiblingFiles(A, L, P)
  return map(split(globpath(expand("%:h") . "/", a:A . "*"), "\n"), 'fnamemodify(v:val, ":t")')
endfunction
command! -nargs=* -complete=customlist,SiblingFiles -bang Rename :call utils#rename("<args>", "<bang>")
cabbrev rename <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "Rename" : "rename"<CR>
" }}}

" {{{ indentLine 
let g:indentline_enabled = 1
let g:indentline_char='┆'
let g:indentLine_fileTypeExclude = ['defx', 'denite', 'startify', 'tagbar', 'vista_kind', 'fzf']
let g:indentLine_concealcursor = 'niv'
let g:indentLine_showFirstIndentLevel = 0
" }}}
