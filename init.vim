"======================================================================
"
" init.vim - 
"
" Created by liubang on 2020/05/24
" Last Modified: 2020/05/24 10:54
"
"======================================================================
" vim: et ts=2 sts=2 sw=2

" {{{ global variables 
let g:nvg_version = 'v2.2'
let g:nvg_root = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let g:nvg_cache_path = expand(g:nvg_root . '/.cache')
let $RT = g:nvg_root
let $MD = g:nvg_root . '/modules'
let s:cache_path = get(g:, 'nvg_cache_path', $HOME . '/.cache')
let s:dein_url = 'https://github.com/Shougo/dein.vim'
let s:toml = g:nvg_root. '/plugins.toml'
let s:lazy_toml = g:nvg_root. '/plugins_lazy.toml'
if !empty($PYTHON3_HOST_PROG)
  let g:python3_host_prog = $PYTHON3_HOST_PROG
elseif !empty($PYTHON_HOST_PROG)
  let g:python_host_prog = $PYTHON_HOST_PROG
endif
" }}}

" {{{ basic
set nocompatible
syntax enable
syntax on
set encoding=UTF-8
set fileencoding=utf-8
scriptencoding UTF-8
set termguicolors
set fileencodings=utf-8,ucs-bom,gbk,gb18030,big5,euc-jp,latin1
set completeopt-=menu
set completeopt+=menuone   " Show the completions UI even with only 1 item
set completeopt-=longest   " Don't insert the longest common text
set completeopt-=preview   " Hide the documentation preview window
set completeopt+=noinsert  " Don't insert text automatically
set completeopt-=noselect  " Highlight the first completion automatically
set modeline
set shortmess=atcOI
set smartcase 
set scrolljump=5
set scrolloff=3
set hidden
set cmdheight=1
set history=1000
set wrap
set hlsearch
set nowritebackup
set noundofile
set nobackup
set noswapfile
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
set smartindent
set cindent
set expandtab
set mousehide
set updatetime=300
set timeout
set timeoutlen=1000
set ttimeout
set ttimeoutlen=10
set noshowcmd
set noshowmode
" 显示匹配的括号
set showmatch
" 显示括号匹配的时间
set matchtime=2
" 延迟绘制（提升性能）
set lazyredraw
" 错误格式
set errorformat+=[%f:%l]\ ->\ %m,[%f:%l]:%m
" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m
" 合并两行中文时，不在中间加空格
set formatoptions+=B
set report=0
set linespace=0
set pumheight=15
set winminheight=0
" 设置Backspace按键模式
set backspace=eol,start,indent
set whichwrap+=<,>,h,l  " Allow backspace and cursor keys to cross line boundaries
set cursorline
set fileformats=unix,dos,mac
set autoread " 文件在Vim之外修改过，自动重新读入
set norelativenumber
set nocursorcolumn
" 禁用报警声和图标
set noerrorbells
set novisualbell
set t_vb=

set cpoptions+=I
set wildmenu
set wildignorecase
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class
set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib 
set wildignore+=__pycache__,.stversions,*.spl,*.out,%*
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android
if matchstr(execute('silent version'), 'NVIM v\zs[^\n-]*') >= '0.4.0'
  set shada=!,'300,<50,@100,s10,h
  set inccommand=nosplit
  set wildoptions+=pum
  set pumblend=10
endif

if executable('rg')
	set grepformat=%f:%l:%m
	let &grepprg = 'rg --vimgrep' . (&smartcase ? ' --smart-case' : '')
elseif executable('ag')
	set grepformat=%f:%l:%m
	let &grepprg = 'ag --vimgrep' . (&smartcase ? ' --smart-case' : '')
endif

" 禁止自动切换目录
set noautochdir

if has('folding')
	set foldenable
  set foldcolumn=0 
	set foldmethod=marker
endif

" session and view
set viewoptions=folds,cursor,curdir,slash,unix
set sessionoptions=curdir,help,tabpages,winsize

" To make vsplit put the new buffer on the right of the current buffer
set splitright
" To make split put the new buffer below the current buffer
set splitbelow

" copy from vim to system clipboard
if has('mac')
  let g:clipboard = {
    \   'name': 'macOS-clipboard',
    \   'copy': {
    \      '+': 'pbcopy',
    \      '*': 'pbcopy',
    \    },
    \   'paste': {
    \      '+': 'pbpaste',
    \      '*': 'pbpaste',
    \   },
    \   'cache_enabled': 0,
    \ }
endif

if has('clipboard')
  set clipboard& clipboard+=unnamedplus
endif

" }}}

" {{{ plugin 
if &runtimepath !~# '/dein.vim'
  let dein_dir = s:cache_path . '/repos/github.com/Shougo/dein.vim'  
  let g:dein#auto_recache = 0
  let g:dein#install_max_processes = 12
  let g:dein#install_progress_type = 'title'
  let g:dein#enable_notification = 0
  if !isdirectory(dein_dir)
    exec '!git clone ' . s:dein_url . ' ' . dein_dir
    autocmd VimEnter * call dein#install() | source $MYVIMRC
    if v:shell_error
      call utils#errmsg('
            \ dein installation has failed! is git installed?')
    endif
  endif
  exec 'set runtimepath+=' . substitute(
        \ fnamemodify(dein_dir, ':p'), 
        \ '/$', '', '')
endif
if dein#load_state(s:cache_path) 
  call dein#begin(s:cache_path, [ 
        \ expand('<sfile>'), 
        \ s:toml, 
        \ s:lazy_toml
        \ ])

  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
  if dein#check_install()
    call dein#install()
  endif
endif
filetype plugin indent on
syntax enable
" Trigger source event hooks
call dein#call_hook('source')
call dein#call_hook('post_source')
" }}}

" {{{ autocmd
augroup UserTermSettings " neovim only
  autocmd!
  autocmd TermOpen *
    \ setlocal signcolumn=no |
    \ setlocal nobuflisted |
    \ setlocal nospell |
    \ setlocal modifiable |
    " \ nmap <silent><buffer> <Esc> <Cmd>hide<CR>|
    \ nmap <silent><buffer> q :q<CR> |
    \ hi TermCursor guifg=yellow
augroup END

augroup FileSyntax
	autocmd!
  autocmd FileType xml,json,text
    \ if getfsize(expand("%")) > 10000000
    \|  setlocal syntax=off
    \|endif
augroup END

" Fast fold
" Credits: https://github.com/Shougo/shougo-s-github
augroup FastFold
	autocmd!
	autocmd TextChangedI,TextChanged *
		\  if &l:foldenable && &l:foldmethod !=# 'manual'
		\|   let b:foldmethod_save = &l:foldmethod
		\|   let &l:foldmethod = 'manual'
		\| endif

	autocmd BufWritePost *
		\  if &l:foldmethod ==# 'manual' && exists('b:foldmethod_save')
		\|   let &l:foldmethod = b:foldmethod_save
		\|   execute 'normal! zx'
		\| endif
augroup END

augroup UserKeywordHighlight
  autocmd!
  autocmd Syntax *
    \ call matchadd('Todo',  '\W\zs\(@TODO\|@FIXME\|@CHANGED\|@XXX\|@BUG\|@HACK\)') |
    \ call matchadd('Todo',  '\W\zs\(@todo\|@fixme\|@changed\|@xxx\|@bug\|@hack\)') |
    \ call matchadd('Todo',  '\W\zs\(@NOTE\|@INFO\|@IDEA\|@NOTICE\)') |
    \ call matchadd('Todo',  '\W\zs\(@note\|@info\|@idea\|@notice\)') |
    \ call matchadd('Debug', '\W\zs\(@DEBUG\|@Debug\|@debug\)') |
    \ call matchadd('Tag',   '\W\zs\(@VOLDIKSS\|@voldikss\)')
augroup END

" restore cursor position when opening file
augroup UserJumpToLastPosition
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") && &filetype != 'gitcommit' |
      \ exe "normal! g'\"" |
    \ endif
augroup END
" }}}

" {{{ mapping

" {{{ basic mapping 
" Release keymappings prefixes
nnoremap <Space> <Nop>
xnoremap <Space> <Nop>
nnoremap ,       <Nop>
xnoremap ,       <Nop>
nnoremap ;       <Nop>
xnoremap ;       <Nop>
nnoremap m       <Nop>
xnoremap m       <Nop>
" leader key
let g:mapleader="\<Space>"
" Use tab for indenting
vnoremap <silent> <Tab> >gv|
vnoremap <silent> <S-Tab> <gv
nmap <silent> <Tab>   >>_
nmap <silent> <S-Tab> <<_
" e -> exchange
" https://github.com/wsdjeg/vim-galore-zh_cn#%E5%BF%AB%E9%80%9F%E7%A7%BB%E5%8A%A8%E5%BD%93%E5%89%8D%E8%A1%8C
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>
" https://github.com/wsdjeg/vim-galore-zh_cn#%E8%81%AA%E6%98%8E%E5%9C%B0%E4%BD%BF%E7%94%A8-n-%E5%92%8C-n
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]
" 防止水平滑动的时候失去选择
xnoremap <  <gv
xnoremap >  >gv
" bash like
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Delete>
" }}}

" {{{ command mod
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <S-Left>
cnoremap <C-f> <S-Right>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <expr> <C-n>  pumvisible() ? '<Right>' : '<Down>'
cnoremap <expr> <C-p>  pumvisible() ? '<Left>' : '<Up>'
cnoremap <expr> <Up>   pumvisible() ? '<C-p>' : '<up>'
cnoremap <expr> <Down> pumvisible() ? '<C-n>' : '<down>'
" }}}

" {{{ buffer 
nnoremap <Leader>bp :bprevious<CR>
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bf :bfirst<CR>
nnoremap <Leader>bl :blast<CR>
nnoremap <Leader>bd :bdelete<CR>
nnoremap <Leader>bk :bwipout<CR>
" }}}

" {{{ window
nnoremap <Leader>ww <C-W>w
nnoremap <Leader>wr <C-W>r
nnoremap <Leader>wd <C-W>c
nnoremap <Leader>wq <C-W>q
nnoremap <Leader>wj <C-W>j
nnoremap <Leader>wJ <C-W>J
nnoremap <Leader>wk <C-W>k
nnoremap <Leader>wK <C-W>K
nnoremap <Leader>wh <C-W>h
nnoremap <Leader>wH <C-W>H
nnoremap <Leader>wl <C-W>l
nnoremap <Leader>wL <C-W>L
nnoremap <Leader>w= <C-W>=
nnoremap <Leader>ws <C-W>s
nnoremap <Leader>w- <C-W>s
nnoremap <Leader>wv <C-W>v
nnoremap <Leader>w\| <C-W>v
" }}}

" {{{ terminal
function s:exit_to_normal() abort
  if &filetype ==# 'fzf'
    return "\<Esc>"
  endif
  return "\<C-\>\<C-n>"
endfunc

tnoremap <expr>  <Esc> <SID>exit_to_normal()
tnoremap <Leader><Esc> <C-\><C-n>
tnoremap <Leader>wh    <C-\><C-N><C-w>h
tnoremap <Leader>wj    <C-\><C-N><C-w>j
tnoremap <Leader>wl    <C-\><C-N><C-w>l
tnoremap <Leader>wk    <C-\><C-N><C-w>k
" }}}

" {{{ plugins mapping 

" Defx
nnoremap <silent><Leader>ft :Defx <CR>

" mundo
nnoremap <silent><Leader>ud :MundoToggle<CR>

" lightline.vim
nmap <silent> <expr> <Leader>1 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(1)"
nmap <silent> <expr> <Leader>2 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(2)"
nmap <silent> <expr> <Leader>3 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(3)"
nmap <silent> <expr> <Leader>4 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(4)"
nmap <silent> <expr> <Leader>5 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(5)"
nmap <silent> <expr> <Leader>6 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(6)"
nmap <silent> <expr> <Leader>7 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(7)"
nmap <silent> <expr> <Leader>8 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(8)"
nmap <silent> <expr> <Leader>9 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(9)"
nmap <silent> <expr> <Leader>0 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(10)"

" markdown-preview.nvim
nnoremap <silent><Leader>mp :MarkdownPreview<CR>

" vim-clang-format
autocmd FileType c,cpp,proto nnoremap <silent><buffer><leader>cf :<c-u>ClangFormat<cr>
autocmd FileType c,cpp,proto vnoremap <silent><buffer><leader>cf :ClangFormat<cr>

" coc.nvim
function! s:check_back_space() abort
  let l:col = col('.') - 1
  return !l:col || getline('.')[l:col - 1]  =~# '\s'
endfunc
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nnoremap <silent><leader>el :CocFzfDiagnostics<CR>
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" goto definition
nmap <silent><leader>gd <Plug>(coc-definition)
" goto declaration
nmap <silent><leader>gD <Plug>(coc-declaration)
" goto type definition
nmap <silent><leader>gy <Plug>(coc-type-definition)
" goto implementation
nmap <silent><leader>gi <Plug>(coc-implementation)
" goto references
nmap <silent><leader>gr <Plug>(coc-references)
" error info
nmap <silent><leader>ei <Plug>(coc-diagnostic-info)
" rename
nmap <silent><leader>rn <Plug>(coc-rename)
nmap <silent><space>y :<C-u>CocList -A --normal yank<cr>
nmap <silent>w <Plug>(coc-ci-w)
nmap <silent>b <Plug>(coc-ci-b)

" fzf
function! s:files()
  let cmd= 'rg --files --hidden --follow --glob "!.git/*"'
  let l:files = split(system(cmd), '\n')
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

function! s:rg(query, bang)
  let preview_opts = a:bang ? fzf#vim#with_preview('up:60%') 
        \ : fzf#vim#with_preview('right:50%')
  let root_dir = asyncrun#get_root('%')
  call extend(preview_opts.options, ['--prompt', root_dir.'> '])
  call fzf#vim#grep(
    \ 'rg --column --line-number --no-heading --smart-case '.shellescape(a:query), 1,
    \ preview_opts,
    \ a:bang,
    \ )
endfunc

command! -bang -nargs=* MyRg call s:rg(<q-args>, <bang>0)
nmap <silent><Leader>? <plug>(fzf-maps-n)
xmap <silent><Leader>? <plug>(fzf-maps-x)
omap <silent><Leader>? <plug>(fzf-maps-o)
nnoremap <silent> <expr> <Leader>ag (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '') . ":MyRg\<cr>"
nnoremap <silent> <expr> <Leader>w? (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '') . ":Windows\<cr>"
nnoremap <silent> <expr> <Leader>f? (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '') . ":Files ~\<cr>"
nnoremap <silent> <expr> <Leader>ht (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '') . ":Helptags\<cr>"
nnoremap <silent> <expr> <C-p>      (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '') . ":call <sid>fzf()\<cr>"

" vista.vim
nnoremap <silent><leader><F3> :Vista!!<CR>
nnoremap <silent><leader>tl :Vista!!<CR>
nnoremap <silent><leader>vf :Vista finder coc<CR>
autocmd WinEnter * if &filetype== 'vista' && winnr('$') == 1 | q | endif

" vim-easymotion
map <Leader>ll <Plug>(easymotion-lineforward)
map <Leader>jj <Plug>(easymotion-j)
map <Leader>kk <Plug>(easymotion-k)
map <Leader>hh <Plug>(easymotion-linebackward)
map  <Leader>ww <Plug>(easymotion-bd-w)
nmap <Leader>ww <Plug>(easymotion-overwin-w)

" asyncrun.vim
nnoremap <Leader>ar :AsyncRun<Space>
" for git
command! -bang -nargs=1 GitCommit
      \ :AsyncRun -cwd=<root> -raw git status && git add . && git commit -m <q-args> && git push origin
nnoremap <Leader>gc :GitCommit<Space>
autocmd WinEnter * if &buftype == 'quickfix' && winnr('$') == 1 | q | endif

" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

" vim-floaterm
nnoremap <silent><Leader>tw :FloatermNew<CR>

" vim-quickui
noremap <silent><Leader>to :call quickui#menu#open()<CR>
nnoremap <silent><expr><Leader>bb (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') 
  . ":call quickui#tools#list_buffer('e')\<CR>"

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" nerdcommenter
map <silent><Leader>cc <Plug>NERDCommenterToggle
map <silent><Leader>cs <Plug>NERDCommenterSexy
map <silent><Leader>cu <Plug>NERDCommenterUncomment

" asynctasks.vim
nnoremap <silent><Leader>ts :TaskListFzf<CR>
nnoremap <silent><C-x> :AsyncTask file-build-and-run<CR>
nnoremap <silent><C-b> :AsyncTask file-build<CR>
nnoremap <silent><C-r> :AsyncTask file-run<CR> 
" }}}

" }}}
