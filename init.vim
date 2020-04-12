" vim: et ts=2 sts=2 sw=2

if !has('nvim')
  finish
endif

let g:nvg_version = 'v2.1'
let g:nvg_root = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let g:nvg_cache_path = expand(g:nvg_root . '/.cache')
let g:nvg_unit = expand(g:nvg_root . '/units')
exec 'set rtp+=' . g:nvg_root
command! -nargs=1 INC exec 'so '. g:nvg_unit . '/' . <args> . '.vim'
call plug#init()
call plug#load(expand(g:nvg_unit . '/plugins.vim'))

INC 'viminit'
INC 'ui'
INC 'tools'
INC 'coder'
