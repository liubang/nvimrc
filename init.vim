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

if !has('nvim') 
  finish
endif

let g:nvg = {
      \ 'version': '2.0',
      \ 'author': 'liubang',
      \ 'home': fnamemodify(resolve(expand('<sfile>:p')), ':h'),
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
let g:nvg.plugin_home = g:nvg.home . '/.cache/'
let g:nvg.components_dir = g:nvg.home . '/units/'

" runtimepath
exec 'set rtp+=' . expand(g:nvg.core)
call boot#run()
