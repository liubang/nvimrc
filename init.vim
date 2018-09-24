" Maintainer: liubang <https://github.com/iliubang>
" Version: 0.1
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8

if &compatible
 set nocompatible
endif

let g:lbvim_version = '0.6-dev'
let g:lbvim_isnvim = has('nvim')
let g:has_python = has('python')
let g:has_python3 = has('python3')
let g:MAC = has('macunix')
let g:LINUX = has('unix') && !has('macunix') && !has('win32unix')
let g:WINDOWS = has('win32') || has('win64') || has('win16') || has('win95')
let g:TMUX = !empty($TMUX)

let g:lbvim_home = g:lbvim_isnvim ? $HOME . '/.config/nvim/' : $HOME . '/.vim/'
let g:lbvim_plug_home = g:lbvim_home . 'plugged/'
let g:lbvim_plug_path = g:lbvim_home . 'autoload/plug.vim'
let g:components_dir = g:lbvim_home . '/com'

if g:WINDOWS
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif
set runtimepath+=$HOME/.vim/core

call core#begin()

CM 'better'
CM 'completor'
CM 'editor'
CM 'fzf'
CM 'theme'
CM 'tags'

call core#end()
