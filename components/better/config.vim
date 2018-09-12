syntax on
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
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
set number
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
set showmatch
set matchtime=5
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
set fillchars=vert:\|,stl:\ ,stlnc:\       " 在被分割窗口之间显示空白
set autoread                               " 文件在Vim之外修改过，自动重新读入
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

" 设置光标为unserscore
" set guicursor=n-v-c:hor20,i:ver50

nnoremap <Space> <NOP>
let g:mapleader="\<Space>"
let g:maplocalleader="\<Space>"

let g:netrw_dirhistmax = 0

" https://github.com/wsdjeg/vim-galore-zh_cn#%E5%BF%AB%E9%80%9F%E7%A7%BB%E5%8A%A8%E5%BD%93%E5%89%8D%E8%A1%8C
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

" 防止水平滑动的时候失去选择
xnoremap <  <gv
xnoremap >  >gv

" https://github.com/wsdjeg/vim-galore-zh_cn#%E8%81%AA%E6%98%8E%E5%9C%B0%E4%BD%BF%E7%94%A8-n-%E5%92%8C-n
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

set listchars=tab:\|\ ,trail:.,extends:>,precedes:< 
set list

" let loaded_matchparen = 1

" Open shell in vim {{{
if g:lbvim_isnvim
    map <Leader>' :terminal<CR>
else
    map <Leader>' :shell<CR>
endif
" }}}

" Quit normal mode {{{
nnoremap <Leader>q  :q<CR>
nnoremap <Leader>Q  :qa!<CR>
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
nnoremap <Leader>bd :bd<CR>
nnoremap <Leader>bk :bw<CR>
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
nnoremap <Leader>wk <C-W>k
nnoremap <Leader>wh <C-W>h
nnoremap <Leader>wl <C-W>l
nnoremap <Leader>wH <C-W>5<
nnoremap <Leader>wL <C-W>5>
nnoremap <Leader>wJ :resize +5<CR>
nnoremap <Leader>wK :resize -5<CR>
nnoremap <Leader>w= <C-W>=
nnoremap <Leader>ws <C-W>s
nnoremap <Leader>w- <C-W>s
nnoremap <Leader>wv <C-W>v
nnoremap <Leader>w\| <C-W>v
nnoremap <Leader>w2 <C-W>v
" }}}

" {{{ copy from vim to system clipboard
set clipboard+=unnamedplus
" }}}
