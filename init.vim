" Maintainer: liubang <https://github.com/iliubang>
" Version: 0.1
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8
let g:lbvim_version = '0.2'
let g:lbvim_home = $HOME.'/.vim.rc'
let g:lbvim_isnvim = has('nvim')
let g:MAC = has('macunix')
let g:LINUX = has('unix') && !has('macunix') && !has('win32unix')
let g:WINDOWS = has('win32') || has('win64')

if g:WINDOWS
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif
set runtimepath+=$HOME/.vim.rc/core

call init#begin()

Plug 'Shougo/deoplete.nvim'
if !has('nvim')
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'mhinz/vim-startify'
Plug 'liuchengxu/eleline.vim'
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'Shougo/unite.vim', { 'on': [] }
" Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'zchee/deoplete-jedi', {'for': ['python']}
" Plug 'tweekmonster/deoplete-clang2', {'for': ['c', 'cpp']}
Plug 'ervandew/supertab'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'iliubang/yadracula'
Plug 'dhruvasagar/vim-table-mode'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'dominikduda/vim_current_word'

call init#end()
