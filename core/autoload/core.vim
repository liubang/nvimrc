"======================================================================
"
" core.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 13:10:03
"
"======================================================================

" Maintainer: liubang <https://github.com/iliubang>
" Version: 0.1
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8
let g:nvg.coder = []

function s:coder_register(lang)
  if index(g:nvg.coder, a:lang) < 0 
    call add(g:nvg.coder, a:lang)    
  endif
endfunc

function! core#begin() abort
  call s:clean_augroup()
  call s:check_dein()
  call s:define_command()
  call s:check_custom_file()
  call s:register_plugs()
endfunc

function! s:clean_augroup() 
  augroup CustGroupCmd
    au!
  augroup END
endfunc

function! core#end() abort
  if exists('*CustomConfig')
    call CustomConfig()
  endif
endfunc

function! s:define_command()
  command! -nargs=+ -bar CCM call s:component(<args>)
  command! -nargs=+ -bar REG call s:coder_register(<args>)
endfunc

function! s:component(name, ...)
  let path = expand(g:nvg.components_dir . a:name . '.vim')    
  if filereadable(path)
    exec 'so ' . path
  endif
endfunc

function! s:register_plugs()
  call dein#begin(g:nvg.plugin_home)
  call dein#add('wsdjeg/dein-ui.vim')
  if exists('*Init')
    call Init()
  endif
  exec 'so ' . g:nvg.components_dir . 'plugins.vim'
  if exists('*CustomPlug')
    call CustomPlug()
  endif
  call dein#end()
  " Update or install plugins if change detected
  if dein#check_install()
    augroup VimCheckInstall
      au!
      au VimEnter * call dein#install()
    augroup END
  endif
  call dein#call_hook('source')
  call dein#call_hook('post_source')
endfunc

function! s:check_custom_file()
  let l:dot_customfile = $HOME . '/.vim.custom'
  if filereadable(expand(l:dot_customfile))
    execute 'so ' . l:dot_customfile
  endif
endfunc

function! s:check_dein()
  let g:dein#auto_recache = 1
  let g:dein#install_max_processes = 16
  " Add dein to vim's runtimepath
  if &runtimepath !~# '/dein.vim'
    let s:dein_dir = g:nvg.plugin_home . '/repos/github.com/Shougo/dein.vim'
    " Clone dein if first-time setup
    if ! isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
      if v:shell_error
        call utils#err('dein installation has failed! is git installed?', 'core.vim')
      endif
    endif
  endif
  execute 'set runtimepath+='.substitute(
        \ fnamemodify(s:dein_dir, ':p') , '/$', '', '')
endfunc
