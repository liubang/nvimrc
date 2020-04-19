" vim: et ts=2 sts=2 sw=2

" {{{ Dein 
command! -bang -nargs=0 DeinClean call map(dein#check_clean(), "delete(v:val, 'rf')")
command! -bang -nargs=0 DeinRecache call dein#recache_runtimepath()
" }}}

" {{{ Defx
let g:defx_icons_enable_syntax_highlight = 1
call defx#custom#option('_', {
      \ 'columns': 'indent:git:icons:filename',
      \ 'winwidth': 30,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 0,
      \ 'buffer_name': '',
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
endfunc

function s:defx_toggle_tree() abort
  if defx#is_directory()
    return defx#do_action('open_or_close_tree')
  endif
  return defx#do_action('drop')
endfunc

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
endfunc

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
  return s:prepend_icon(l:files)
endfunc

function! s:prepend_icon(candidates)
  let l:result = []
  for l:candidate in a:candidates
    let l:filename = fnamemodify(l:candidate, ':p:t')
    let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
    call add(l:result, printf('%s %s', l:icon, l:candidate))
  endfor
  return l:result
endfunc

function! s:edit_file(item)
  let l:pos = stridx(a:item, ' ')
  let l:file_path = a:item[pos+1:-1]
  execute 'silent e' l:file_path
endfunc

" Files + devicons
function! s:fzf()
  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink': function('s:edit_file'),
        \ 'options': '-m ' . utils#fzf_options('Files'),
        \ 'down': '30%'})
endfunc

nmap <silent><Leader>? <plug>(fzf-maps-n)
xmap <silent><Leader>? <plug>(fzf-maps-x)
omap <silent><Leader>? <plug>(fzf-maps-o)

" https://github.com/junegunn/fzf/issues/453
nnoremap <silent> <expr> <Leader>ag (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '') . ":Rg\<cr>"
nnoremap <silent> <expr> <Leader>w? (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '') . ":Windows\<cr>"
nnoremap <silent> <expr> <Leader>f? (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '') . ":Files ~\<cr>"
nnoremap <silent> <expr> <Leader>ht (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '') . ":Helptags\<cr>"
nnoremap <silent> <expr> <C-p>      (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '') . ":call <sid>fzf()\<cr>"
" nnoremap <silent> <expr> <Leader>bb (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":Buffer\<cr>"
" }}}

" {{{ vim_current_word
let g:vim_current_word#enabled = 1
let g:vim_current_word#highlight_twins = 1
let g:vim_current_word#highlight_current_word = 0
let g:vim_current_word#highlight_only_in_focused_window = 1
autocmd FileType defx :let b:vim_current_word_disabled_in_this_buffer = 1
" }}}

" {{{ Vista
let g:vista#renderer#enable_icon = 1
let g:vista_default_executive = 'ctags'
let g:vista_icon_indent = [" ", " "]
let g:vista_echo_cursor = 0
let g:vista_fzf_preview = ['right:50%']
let g:vista_executive_for = {
  \ 'markdown': 'toc',
  \ 'vim': 'ctags',
  \ 'go': 'coc',
  \ 'c': 'coc',
  \ 'cpp': 'coc',
  \ 'javascript': 'coc',
  \ 'typescript': 'coc',
  \ }

" tab list
nnoremap <silent><leader><F3> :Vista!!<CR>
nnoremap <silent><leader>tl :Vista!!<CR>
nnoremap <silent><leader>vf :Vista finder coc<CR>
autocmd WinEnter * if &filetype== 'vista' && winnr('$') == 1 | q | endif
" }}}

" easymotion {{{
" map <Leader><Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
map <Leader>ll <Plug>(easymotion-lineforward)
map <Leader>jj <Plug>(easymotion-j)
map <Leader>kk <Plug>(easymotion-k)
map <Leader>hh <Plug>(easymotion-linebackward)

" Move to word
map  <Leader>ww <Plug>(easymotion-bd-w)
nmap <Leader>ww <Plug>(easymotion-overwin-w)
" }}}

" {{{ AsyncRun
let g:asyncrun_open = 25
let g:asyncrun_bell = 1
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml'] 
nnoremap <Leader>ar :AsyncRun<Space>
" for git
command! -bang -nargs=1 GitCommit
      \ :AsyncRun -cwd=<root> -raw git status && git add . && git commit -m <q-args> && git push origin
nnoremap <Leader>gc :GitCommit<Space>
autocmd WinEnter * if &buftype == 'quickfix' && winnr('$') == 1 | q | endif
" }}}

" {{{ vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)
" }}}

" {{{ vim-floaterm
let g:floaterm_wintype = 'normal'
let g:floaterm_position = 'bottom'
let g:floaterm_height = 0.35
let g:floaterm_keymap_toggle = '<Ctrl>-d'
let g:floaterm_open_command = 'split'
nnoremap <silent><Leader>tw :FloatermNew<CR>
" }}}

" {{{ quickui
" copied from https://github.com/skywind3000/vim
function! MenuHelp_TaskList()
  let keymaps = '123456789abcdefimnopqrstuvwxyz'
  let items = asynctasks#list('')
  let rows = []
  let size = strlen(keymaps)
  let index = 0
  for item in items 
    if item.name =~ '^\.'
      continue
    endif
    let cmd = strpart(item.command, 0, (&columns * 60) / 100)
    let key = (index >= size)? ' ' : strpart(keymaps, index, 1)
    let text = "[" . ((key != ' ')? ('&' . key) : ' ') . "]\t"
    let text .= item.name . "\t[" . item.scope . "]\t" . cmd
    let rows += [[text, 'AsyncTask ' . fnameescape(item.name)]]
    let index += 1
  endfor
  let opts = {}
  let opts.title = 'Task List'
  call quickui#tools#clever_listbox('tasks', rows, opts)
endfunc

if exists('*nvim_open_win') > 0
  call quickui#menu#reset()
  call quickui#menu#install('&File', [
        \ [ "&Open\t(:e)", 'call feedkeys(":e ")' ],
        \ [ "&Save\t(:w)", 'write' ],
        \ [ "--", ],
        \ [ "File &Explorer", 'Defx', 'Taggle file exporer' ],
        \ [ "Switch &Files", 'Files .' ],
        \ [ "Switch &Buffers", 'call quickui#tools#list_buffer("e")' ],
        \ [ "--", ],
        \ [ "E&xit", 'qa' ],
        \ ])

  call quickui#menu#install('&Edit', [
        \ [ "&Trailing Space", 'call utils#strip_trailing_whitespace()', '' ],
        \ [ 'Update &ModTime', 'call comment#update()' ],
        \ [ '&CopyRight', 'call comment#copyright("liubang")' ],
        \ [ "&Find\t", 'Ag', '' ],
        \ [ "F&ormat", 'Format' ],
        \ [ "Taggle Co&mment", 'call feedkeys("\<Plug>NERDCommenterToggle")' ],
        \ [ "&Hex Edit", 'Vinarise', 'Ultimate hex editing system with Vim' ],
        \ ])

  call quickui#menu#install('&Build', [
        \ [ "File &Execute\t<Ctrl-r>", 'AsyncTask file-run' ],
        \ [ "File &Compile\t<Ctrl-b>", 'AsyncTask file-build' ],
        \ [ "Compile And E&xecute\t<Ctrl-x>", 'AsyncTask file-build-and-run' ],
        \ [ "File &Make", 'AsyncTask make' ],
        \ [ '--','' ],
        \ [ "&Task List", 'call MenuHelp_TaskList()' ],
        \ [ '--','' ],
        \ [ "Clang &Format", 'ClangFormat' ],
        \ ])

  call quickui#menu#install('&Tools', [
        \ [ "View &Diff", 'Gdiffsplit' ], 
        \ [ "Show &Log", 'Gclog' ],
        \ [ "Git &Blame", 'Gblame' ],
        \ [ '--', '' ],
        \ [ "List &Function", 'call quickui#tools#list_function()', '' ],
        \ [ "Display &Messages", 'call quickui#tools#display_messages()', '' ],
        \ [ "&Tagbar", 'Vista!!', '' ],
        \ [ "&Choose Window/Tab", 'ChooseWin', '' ],
        \ [ "Display Ca&lendar", 'Calendar -first_day=monday', '' ],
        \ [ "Ter&minal", 'FloatermToggle', '' ],
        \ [ '--', '' ],
        \ [ "Plugin &Update", 'DeinUpdate', '' ],
        \ ])

  call quickui#menu#install('Help (&?)', [
        \ [ "&Cheatsheet", 'help index', '' ],
        \ [ 'T&ips', 'help tips', '' ],
        \ [ '--','' ],
        \ [ "&Tutorial", 'help tutor', '' ],
        \ [ '&Quick Reference', 'help quickref', '' ],
        \ [ '&Summary', 'help summary', '' ],
        \ [ '--','' ],
        \ [ "&Vim Script", 'help eval', '' ], 
        \ [ "&Function List", 'help function-list', '' ],
        \ ], 10000)
  let g:quickui_color_scheme = 'gruvbox'
  let g:quickui_border_style = 2
  " let g:quickui_show_tip = 1
  " tool bar open
  noremap <silent><Leader>to :call quickui#menu#open()<CR>
  nnoremap <silent><expr><Leader>bb (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":call quickui#tools#list_buffer('e')\<CR>"
endif
" }}}

" {{{ vim-easy-align 
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" }}}

" {{{ nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCreateDefaultMappings = 0
let g:NERDRemoveExtraSpaces = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
map <silent><Leader>cc <Plug>NERDCommenterToggle
map <silent><Leader>cs <Plug>NERDCommenterSexy
map <silent><Leader>cu <Plug>NERDCommenterUncomment
" }}}

" {{{ asynctask
let g:asynctasks_term_pos = 'right'
let g:asynctasks_term_reuse = 0
function! s:asynctask_run(item)
  let p1 = stridx(a:item, '<')
  if p1 > 0 
    let name = strpart(a:item, 0, p1)
    let name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')
    if name != ''
      exec "AsyncTask ". fnameescape(name)
    endif
  endif
endfunc
function! s:fzf_tasks_list() 
  let rows = asynctasks#source(&columns * 48 / 100)
  let source = []
  for row in rows 
    let source += [row[0]. '  ' . row[1] . '  : ' . row[2]]
  endfor
  call fzf#run({
    \ 'source': source,
    \ 'sink': function('s:asynctask_run'),
    \ 'options': utils#fzf_options('TaskList'),
    \ 'down': '20%',
    \ })
endfunc
command! -bang -nargs=0 TaskList call MenuHelp_TaskList()
command! -bang -nargs=0 TaskListFzf call s:fzf_tasks_list()
nnoremap <silent><Leader>ts :TaskListFzf<CR>
nnoremap <silent><C-x> :AsyncTask file-build-and-run<CR>
nnoremap <silent><C-b> :AsyncTask file-build<CR>
nnoremap <silent><C-r> :AsyncTask file-run<CR> 
" }}}
