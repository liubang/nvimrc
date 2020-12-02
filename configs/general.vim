" Disable distribution plugins {{{
let g:loaded_gzip = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1

let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1

let g:loaded_matchit = 1
let g:loaded_2html_plugin = 1
let g:loaded_logiPat = 1
let g:loaded_rrhelper = 1

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1
" }}}

" Message output on vim actions {{{
set shortmess=                        " remove defaults
set shortmess+=t                      " truncate file messages at start
set shortmess+=A                      " ignore annoying swap file messages
set shortmess+=o                      " file-read message overwrites previous
set shortmess+=O                      " file-read message overwrites previous
set shortmess+=T                      " truncate non-file messages in middle
set shortmess+=f                      " (file x of x) instead of just (x of x)
set shortmess+=F                      "Don't give file info when editing a file
set shortmess+=s
set shortmess+=c
" }}}

" better {{{
set encoding=utf-8
set fileencoding=utf-8
set termguicolors          "Enable tru color
set synmaxcol=2500         " Don't syntax highlight long lines
set completeopt+=noinsert,noselect,longest
set completeopt-=preview
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
set nobackup
set noswapfile
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set textwidth=120
set autoindent
set smartindent
set cindent
set updatetime=300
set timeout timeoutlen=500 ttimeoutlen=10
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
" 光标形状
" default value is guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
" set guicursor=i-ci-ve:ver25,n-v-c-sm:hor50,r-cr-o:hor20
" au VimLeave * set guicursor=a:hor50-blinkon0
set listchars=tab:»·,nbsp:+,trail:·,extends:→,precedes:←
" set list
" exclude usetab as we do not want to jump to buffers in already open tabs
" do not use split or vsplit to ensure we don't open any new windows
set switchbuf=useopen,uselast
set fillchars=vert:│
set fillchars+=fold:\ 
set fillchars+=diff: "alternatives: ⣿ ░
if has('nvim-0.3.1')
  set fillchars+=msgsep:‾
  " suppress ~ at EndOfBuffer
  set fillchars+=eob:\ 
endif
if has('nvim-0.5')
  set fillchars+=foldopen:▾,foldsep:│,foldclose:▸
endif
set cpoptions+=I
" 禁止自动切换目录
set noautochdir

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

" Mouse {{{
set mousehide
" set mouse mode to all so it can be used in any circumstance I want it
" e.g. whilst scrolling the pager in tmux
set mouse=vr
set mousefocus
if !has('nvim')
  set ttymouse=xterm2
endif
set secure  " Disable autocmd etc for project local vimrc files.
set exrc " Allow project local vimrc files example .nvimrc see :h exrc
" }}}

" Wild and file globbing stuff in command mode {{{
" Use faster grep alternatives if possible
if executable('rg')
  set grepprg=rg\ --hidden\ --glob\ \"!.git\"\ --no-heading\ --smart-case\ --vimgrep\ --follow\ $*
  set grepformat^=%f:%l:%c:%m
elseif executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --vimgrep
  set grepformat^=%f:%l:%c:%m
endif
"pressing Tab on the command line will show a menu to complete buffer and file names
set wildchar=<Tab>
set wildmenu
set wildmode=full       " Shows a menu bar as opposed to an enormous list
set wildcharm=<C-Z>
set wildignorecase " Ignore case when completing file names and directories
" Binary
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.dll,*.jar,*.pyc,*.rbc,*.class
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.doc,*.pdf
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
" Cache
set wildignore+=.sass-cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*.gem
" Temp/System
set wildignore+=*.*~,*~
set wildignore+=*.swp,.lock,.DS_Store,._*,tags.lock
if has('nvim-0.4')
  set shada=!,'300,<50,@100,s10,h
  set inccommand=nosplit
  set wildoptions=pum
  set pumblend=3  " Make popup window translucent
endif
" }}}

" Folds {{{
set foldenable
set foldtext=folds#render()
set foldopen+=search
" This is overwritten in lsp-fold compatible files by Coc
set foldmethod=syntax
set foldlevelstart=10
" The fold open and close markers are visually distracting
" and if the code is too nested it starts rendering fold depth
set foldcolumn=0
" }}}

" Format Options {{{
" Input auto-formatting (global defaults)
" Probably need to update these in after/ftplugin too since ftplugins will
" probably update it.
set formatoptions=
set formatoptions+=1
set formatoptions-=q                  " continue comments with gq"
set formatoptions+=c                  " Auto-wrap comments using textwidth
set formatoptions+=r                  " Continue comments when pressing Enter
set formatoptions-=o                  " do not continue comment using o or O
set formatoptions+=n                  " Recognize numbered lists
set formatoptions+=2                  " Use indent from 2nd line of a paragraph
set formatoptions+=t                  " autowrap lines using text width value
set formatoptions+=j                  " remove a comment leader when joining lines.
" Only break if the line was not longer than 'textwidth' when the insert
" started and only at a white character that has been entered during the
" current insert command.
set formatoptions+=lv
" }}}

" basic mapping {{{
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
" 防止水平滑动的时候失去选择
xnoremap <  <gv
xnoremap >  >gv
" bash like
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Delete>
" }}}

" command mod {{{
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

" buffer {{{
nnoremap <Leader>bp :bprevious<CR>
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bf :bfirst<CR>
nnoremap <Leader>bl :blast<CR>
nnoremap <Leader>bd :bdelete<CR>
nnoremap <Leader>bk :bwipout<CR>
" }}}

" window {{{
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

" terminal {{{
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
