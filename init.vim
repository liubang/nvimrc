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

let g:nvg = {
      \ 'version': '1.0',
      \ 'author': 'liubang',
      \ 'home': expand('<sfile>:h'),
      \ 'os': {
      \   'mac': has('macunix'),
      \   'linux': has('unix') && !has('macunix') && !has('win32unix'),
      \ },
      \ 'tmux': !empty($TMUX),
      \ 'nvim': has('nvim'),
      \ 'termguicolors': has('termguicolors'),
      \ 'build': {}
      \ }

let g:nvg.core = g:nvg.home . '/core'
let g:nvg.plugin_home = g:nvg.home . '/plugged/'
let g:nvg.vim_plug_path = g:nvg.home . '/core/autoload/plug.vim'
let g:nvg.components_dir = g:nvg.home . '/units'
let g:nvg.cache_dir = g:nvg.home . '/cache'

" runtimepath
exec 'set rtp+=' . expand(g:nvg.core)

call boot#run()
