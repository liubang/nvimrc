"======================================================================
"
" init.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 13:01:42
"
"======================================================================

" Maintainer: liubang <https://github.com/iliubang>
" Version: 0.1
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8

" 防止重复加载
if get(s:, 'loaded', 0) != 0 || v:version < 800
  finish
else
  let s:loaded = 1
endif

if &compatible
 set nocompatible
endif

let g:python_host_skip_check=1
let g:python3_host_skip_check=1
let g:python3_host_prog = 'python3'

let g:HAS_PYTHON3 = has('python3')

if !g:HAS_PYTHON3 
  echohl ErrorMsg
  echom 'Please reinstall your vim/nvim with supporting for python3.'
  echohl None
  finish
endif

let g:LBVIM_VERSION = '0.7-dev'
let g:IS_NVIM = has('nvim')
let g:HAS_TMUX = !empty($TMUX)
let g:HAS_GUICOLORS = has("termguicolors")
let g:IS_MAC = has('macunix')
let g:IS_LINUX = has('unix') && !has('macunix') && !has('win32unix')
let g:IS_WINDOWS = has('win32') || has('win64') 

let g:vim_home = g:IS_NVIM ? $HOME . '/.config/nvim' : $HOME . '/.vim'
let g:vim_plug_home = g:vim_home . '/plugged/'
let g:vim_plug_path = g:vim_home . '/core/autoload/plug.vim'
let g:components_dir = g:vim_home . '/units'

if g:IS_WINDOWS
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

if g:IS_NVIM
  set runtimepath+=$HOME/.config/nvim/core
else
  set runtimepath+=$HOME/.vim/core
endif

call core#begin()
  CCM 'vim'
  CCM 'theme'
  CCM 'editor'
  CCM 'completor'
  CCM 'tags'
call core#end()
