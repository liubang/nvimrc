" Maintainer: liubang <https://github.com/iliubang>
" Version: 0.1
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8

let g:lbvim_version = '0.1'
let g:lbvim_home = $HOME.'/.vim.rc'

let g:MAC = has('macunix')
let g:LINUX = has('unix') && !has('macunix') && !has('win32unix')
let g:WINDOWS = has('win32') || has('win64')

if g:WINDOWS
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif
set runtimepath+=$HOME/.vim.rc

function! s:lbvimbegin() abort
  let l:vim_plug_path = '~/.vim/autoload/plug.vim'
  call s:check_vim_plug(l:vim_plug_path)
endfunction

function! s:check_vim_plug(plug_path)
  if empty(glob(a:plug_path))
    echo '==> Downloading vim-plug ......'
    execute '!curl -fLo ' . a:plug_path . ' --create-dirs ' .
          \   'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  endif
endfunction

call s:lbvimbegin()

call plug#begin('~/.vim/plugged')
  Plug 'mhinz/vim-startify'
  Plug 'ayu-theme/ayu-vim'
  Plug 'liuchengxu/eleline.vim'
  Plug 'SirVer/ultisnips'
  Plug 'iliubang/vim-snippets'
  Plug 'easymotion/vim-easymotion'
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-surround'
  Plug 'Shougo/unite.vim'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'scrooloose/nerdtree'
  Plug 'dracula/vim'
call plug#end()

" smart default
syntax on
set shortmess=atOI
set ignorecase
set smartcase 
set scrolljump=5
set scrolloff=3
set hidden
set history=100
set nowrap
set hlsearch
set nowritebackup
set noundofile
set nobackup
set noswapfile
set number
set shiftwidth=4
set tabstop=4
set softtabstop=4
set mousehide
set t_Co=256
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
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set wildignore+=*swp,*.class,*.pyc,*.png,*.jpg,*.gif,*.zip
set wildignore+=*/tmp/*,*.o,*.obj,*.so     " Unix
set wildignore+=*\\tmp\\*,*.exe            " Windows
set cursorline
set fileformats=unix,dos,mac
set fillchars=vert:│,stl:\ ,stlnc:\        " 在被分割窗口之间显示空白
set autoread                               " 文件在Vim之外修改过，自动重新读入

" about theme {
if !g:MAC
  set background=dark
  set termguicolors
endif
set background=dark
"let ayucolor="dark"
"colorscheme ayu
colorscheme dracula
set laststatus=2
" }

try
  execute 'source '.g:lbvim_home.'/startify.vim'
catch
endtry

" vim-startify {
let g:startify_custom_header = g:vim#startify#header
let g:startify_list_order = g:vim#startify#order
let g:startify_change_to_vcs_root = 1
" }

nnoremap <Space> <NOP>
let g:mapleader="\<Space>"
let g:maplocalleader="\<Space>"

" Open shell in vim
if has('nvim')
  map <Leader>' :terminal<CR>
else
  map <Leader>' :shell<CR>
endif

" Quit normal mode
nnoremap <Leader>q  :q<CR>
nnoremap <Leader>Q  :qa!<CR>
" Bash like
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Delete>
" Quit visual mode
vnoremap v <Esc>
" buffer
nnoremap <Leader>bp :bprevious<CR>
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bf :bfirst<CR>
nnoremap <Leader>bl :blast<CR>
nnoremap <Leader>bd :bd<CR>
nnoremap <Leader>bk :bw<CR>
" window
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

" easymotion {
map <Leader><Leader> <Plug>(easymotion-prefix)
" Consistent with spacemacs
" <Leader>f{char} to move to {char}
map  <Leader>jj <Plug>(easymotion-bd-f)
nmap <Leader>jj <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap <Leader>jJ <Plug>(easymotion-overwin-f2)
" Jump to line
map <Leader>jl <Plug>(easymotion-bd-jk)
nmap <Leader>jl <Plug>(easymotion-overwin-line)
" Jump to word
map  <Leader>jw <Plug>(easymotion-bd-w)
nmap <Leader>jw <Plug>(easymotion-overwin-w)
" }

" nerdtree {
let g:NERDTreeShowHidden=1
let g:NERDTreeAutoDeleteBuffer=1
" ❯
let g:NERDTreeDirArrowExpandable = "\u276f" 
" ▽
let g:NERDTreeDirArrowCollapsible = "\u25bd"
let g:NERDTreeIgnore=[
              \ '\.py[cd]$', '\~$', '\.swo$', '\.swp$', '\.DS_Store$',
              \ '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$',
              \ ]
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

nnoremap <F4> :NERDTreeToggle<CR>
inoremap <F4> <ESC>:NERDTreeToggle<CR>
nnoremap <Leader>ft :NERDTreeToggle<CR>
nnoremap <Leader>fd :NERDTreeFind<CR>
" }

