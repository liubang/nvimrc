"======================================================================
"
" viminit.vim - 
"
" Created by liubang on 2020/01/21
" Last Modified: 2020/01/21 16:30
"
"======================================================================

" {{{ basic
set nocompatible
syntax enable
syntax on
set encoding=UTF-8
set fileencoding=utf-8
scriptencoding UTF-8
set fileencodings=utf-8,ucs-bom,gbk,gb18030,big5,euc-jp,latin1
" set completeopt=noinsert,menuone,noselect
set completeopt-=menu
set completeopt+=menuone
set completeopt-=longest
set completeopt-=preview
set completeopt+=noinsert
set completeopt-=noselect
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
set pumheight=30
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
  set shada='20,<50,s10
  set inccommand=nosplit
  set wildoptions+=pum
  set pumblend=10
endif

" 禁止自动切换目录
set noautochdir

if has('folding')
	set foldenable
  set foldcolumn=0 
	set foldmethod=marker
endif
" session
set sessionoptions+=globals

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

" {{{ autocmd
autocmd FileType xml,json,text
      \ if getfsize(expand("%")) > 10000000
      \|  setlocal syntax=off
      \|endif

" restore cursor position when opening file
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$")
      \|  execute "normal! g`\""
      \|endif
" }}}

" {{{ mapping
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

" command mod
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

" buffer 
nnoremap <Leader>bp :bprevious<CR>
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bf :bfirst<CR>
nnoremap <Leader>bl :blast<CR>
nnoremap <Leader>bd :bdelete<CR>
nnoremap <Leader>bk :bwipout<CR>

" window
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

" terminal
function s:exit_to_normal() abort
  if &filetype ==# 'fzf'
    return "\<Esc>"
  endif
  return "\<C-\>\<C-n>"
endfunc

tnoremap <expr> <Esc> <SID>exit_to_normal()
tnoremap <Leader><Esc> <C-\><C-n>
tnoremap <Leader>wh <C-\><C-N><C-w>h
tnoremap <Leader>wj <C-\><C-N><C-w>j
tnoremap <Leader>wl <C-\><C-N><C-w>l
tnoremap <Leader>wk <C-\><C-N><C-w>k
" }}}
