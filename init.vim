"======================================================================
"
" init.vim - 
"
" Created by liubang on 2020/05/24
" Last Modified: 2020/05/24 10:54
"
"======================================================================
" vim: et ts=2 sts=2 sw=2

filetype off

augroup vimrc "Ensure all autocommands are cleared
  autocmd!
augroup END

let g:nvg_version = 'v2.2'
let g:nvg_root = fnamemodify(resolve(expand('<sfile>:p')), ':h')

call pm#_start()

runtime configs/general.vim
runtime configs/mappings.vim
runtime configs/autocmds.vim
