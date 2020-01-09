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

let g:nvg.components_loaded = []
let g:nvg.plugins = []
let g:nvg.coder = []

let s:called = {
  \ 'begin': 0,
  \ 'end': 0
  \ }

function s:coder_register(lang)
  if index(g:nvg.coder, a:lang) < 0 
    call add(g:nvg.coder, a:lang)    
  endif
endfunc

function! core#begin() abort
  if s:called.begin != 0
    return
  else
    let s:called.begin = 1
  endif
  call s:check_dein()
  call s:define_command()
  call s:check_custom_file()
endfunc

function! core#end() abort
  if s:called.end != 0
    return
  else
    let s:called.end = 1
  endif
  " regist all plugs
  call s:register_plugs()
  call s:register_configs()
  if exists('*CustomConfig')
    call CustomConfig()
  endif
endfunc

function! s:define_command()
  command! -nargs=+ -bar CCM call s:component(<args>)
  command! -nargs=+ -bar REG call s:coder_register(<args>)
endfunc

function! s:component(name, ...)
  if index(g:nvg.components_loaded, a:name) < 0
    call add(g:nvg.components_loaded, a:name)
  endif
endfunc

function! s:register_plugs()
  if dein#load_state(g:nvg.plugin_home) 
    call dein#begin(g:nvg.plugin_home)
    call dein#add('wsdjeg/dein-ui.vim')
    if exists('*Init')
      call Init()
    endif
    for l:component in g:nvg.components_loaded
      let l:component_package = g:nvg.components_dir . '/' . l:component . '/package.vim'
      try
        execute 'so ' . l:component_package
      catch
        return utils#err(v:exception, l:component_package)
      endtry
    endfor
    if exists('*CustomPlug')
      call CustomPlug()
    endif
    call dein#end()
    call dein#save_state()
    " Update or install plugins if change detected
    if dein#check_install()
      call dein#install()
    endif
  endif
  call dein#call_hook('source')
endfunc

function! s:register_configs()
  for l:component in g:nvg.components_loaded
    let l:component_config = g:nvg.components_dir . '/' . l:component . '/config.vim'
    try
      execute 'so ' . l:component_config
    catch
      return utils#err(v:exception, l:component_config)
    endtry
  endfor
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
  let g:dein#enable_notification = 1
  let g:dein#install_progress_type = 'echo'
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
