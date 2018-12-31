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

let g:lbvim = {
      \ 'version': '0.7-dev',
      \ 'os': {
      \     'mac': has('macunix'),
      \     'linux': has('unix') && !has('macunix') && !has('win32unix'),
      \ },
      \ 'tmux': !empty($TMUX),
      \ 'nvim': has('nvim'),
      \ 'termguicolors': has('termguicolors'),
      \ }

let g:lbvim.home = g:lbvim.nvim ? $HOME . '/.config/nvim' : $HOME . '/.vim'
let g:lbvim.plugin_home = g:lbvim.home . '/plugged/'
let g:lbvim.vim_plug_path = g:lbvim.home . '/core/autoload/plug.vim'
let g:lbvim.components_dir = g:lbvim.home . '/units'

if g:lbvim.nvim
  set runtimepath+=$HOME/.config/nvim/core
else
  set runtimepath+=$HOME/.vim/core
endif

call boot#run()
