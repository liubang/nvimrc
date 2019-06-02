"======================================================================
"
" config.vim - 
"
" Created by liubang on 2018/11/23
" Last Modified: 2018/11/23 18:09:06
"
"======================================================================

if has('syntax')
  syntax enable
  syntax on
endif

set encoding=UTF-8
set fileencoding=utf-8
scriptencoding UTF-8
set fileencodings=utf-8,ucs-bom,gbk,gb18030,big5,euc-jp,latin1
set shortmess=atOI
set ignorecase
set smartcase 
set scrolljump=5
set scrolloff=3
set hidden
set history=100
set wrap
set hlsearch
set nowritebackup
set noundofile
set nobackup
set noswapfile
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent
set smartindent
set cindent
set expandtab
set mousehide
set ruler
set showcmd
set showmode
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
" 文件换行符，默认使用 unix 换行符
set ffs=unix,dos,mac

set report=0
set linespace=0
set pumheight=20
set winminheight=0
set wildmode=list:longest,full
set backspace=2         " 在insert模式下用退格键删除
set whichwrap+=<,>,h,l  " Allow backspace and cursor keys to cross line boundaries
set wildignore+=*swp,*.class,*.pyc,*.png,*.jpg,*.gif,*.zip
set wildignore+=*/tmp/*,*.o,*.obj,*.so     " Unix
set wildignore+=*\\tmp\\*,*.exe            " Windows
set cursorline
set fileformats=unix,dos,mac
set autoread                                  " 文件在Vim之外修改过，自动重新读入
set synmaxcol=200
set norelativenumber
"set colorcolumn=120
set nocursorcolumn
" Enable folding
" 快捷键：z+a, 打开或关闭当前折叠;  z+m, 关闭所有折叠;  z+r, 打开所有折叠
" set nofoldenable  "启动vim时候关闭折叠
set foldmethod=marker
set foldcolumn=0 
" set foldlevel=99
" 禁用报警声和图标
set noerrorbells
set novisualbell
set t_vb=

" 利用通配符进行缓冲区跳转
set wildmenu
set wildmode=longest:list,full

" 禁止自动切换目录
set noautochdir

"----------------------------------------------------------------------
" 文件搜索和补全时忽略下面扩展名
"----------------------------------------------------------------------
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class

set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib "stuff to ignore when tab completing
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz    " MacOSX/Linux
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

" 將g:netrw_dirhistmax設置為零，netrw將不保存歷史記錄或書籤
let g:netrw_dirhistmax = 0

" 设置光标为unserscore
" set guicursor=n-v-c:hor20,i:ver50

" Release keymappings prefixes
nnoremap <Space> <Nop>
xnoremap <Space> <Nop>
nnoremap ,       <Nop>
xnoremap ,       <Nop>
nnoremap ;       <Nop>
xnoremap ;       <Nop>
nnoremap m       <Nop>
xnoremap m       <Nop>
let g:mapleader="\<Space>"
let g:maplocalleader="\<Space>"

" Use tab for indenting
vnoremap <silent> <Tab> >gv|
vnoremap <silent> <S-Tab> <gv
nmap <silent> <Tab>   >>_
nmap <silent> <S-Tab> <<_

" https://github.com/wsdjeg/vim-galore-zh_cn#%E5%BF%AB%E9%80%9F%E7%A7%BB%E5%8A%A8%E5%BD%93%E5%89%8D%E8%A1%8C
" e -> exchange
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

" 防止水平滑动的时候失去选择
xnoremap <  <gv
xnoremap >  >gv

" https://github.com/wsdjeg/vim-galore-zh_cn#%E8%81%AA%E6%98%8E%E5%9C%B0%E4%BD%BF%E7%94%A8-n-%E5%92%8C-n
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

" Allow misspellings
cnoreabbrev qw wq
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Qa qa
cnoreabbrev Bd bd
cnoreabbrev bD bd

" Yank buffer's absolute path to X11 clipboard
nnoremap <silent> <Leader>y :let @+=expand("%")<CR>:echo 'Relative path copied to clipboard.'<CR>
nnoremap <silent> <Leader>Y :let @+=expand("%:p")<CR>:echo 'Absolute path copied to clipboard.'<CR>

" Drag current line/s vertically and auto-indent
" vnoremap <silent> mk :m-2<CR>gv=gv
" vnoremap <silent> mj :m'>+<CR>gv=gv
" noremap <silent> mk :m-2<CR>
" noremap <silent> mj :m+<CR>

" let loaded_matchparen = 1

" Open shell in vim {{{
if g:lbvim.nvim
    map <Leader>' :terminal<CR>
else
    map <Leader>' :shell<CR>
endif
" }}}

" Quit normal mode {{{
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :qa!<CR>
" }}}

" Bash like {{{
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Delete>
" }}}

" Quit visual mode {{{
vnoremap v <Esc>
" }}}

" buffer {{{
nnoremap <Leader>bp :bprevious<CR>
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bf :bfirst<CR>
nnoremap <Leader>bl :blast<CR>
nnoremap <Leader>bd :bdelete<CR>
nnoremap <Leader>bk :bwipout<CR>
" }}}

" window {{{
" To make vsplit put the new buffer on the right of the current buffer
set splitright
" To make split put the new buffer below the current buffer
set splitbelow
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

" {{{ copy from vim to system clipboard
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

" {{{ autocmd 

"----------------------------------------------------------------------
" autocmd 
"----------------------------------------------------------------------
autocmd FileType xml,json,text
      \ if getfsize(expand("%")) > 10000000
      \|  setlocal syntax=off
      \|endif

" restore cursor position when opening file
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$")
      \|  execute "normal! g`\""
      \|endif

" http://vim.wikia.com/wiki/Speed_up_Syntax_Highlighting
autocmd BufEnter * :syntax sync maxlines=200

" http://vim.wikia.com/wiki/Always_start_on_first_line_of_git_commit_message
autocmd BufEnter * if &filetype == "gitcommit" | call setpos('.', [0, 1, 1, 0]) | endif
" }}}

" {{{ command
command! -nargs=0 -bang CleanBuffer call utils#clean_buffers()
" }}}
