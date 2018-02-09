" Maintainer: liubang <https://github.com/iliubang>
" Version: 0.1
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8

function! defaults#better#init()
    " smart default {{{
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
    set autoindent
    set smartindent
    set cindent
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
    set termencoding=utf-8
    set fileencoding=utf-8
    set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
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
    " }}}
endfunction