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

let g:lbvim.components_loaded = []
let g:lbvim.plugins = []
let s:type = {
      \ 'string': type(''),
      \ 'list': type([]),
      \ 'dict': type({}),
      \ 'function': type(function('call'))
      \ }

function! core#begin() abort
  call s:check_vim_plug()
  call s:define_command()
  call s:check_custom_file()
endfunction

function! core#end() abort
  " regist all plugs
  call s:register_plugs()
  call s:register_configs()

  if exists('*CustomConfig')
    call CustomConfig()
  endif
endfunction

function! s:define_command()
  command! -nargs=+ -bar MMP call s:my_plugin(<args>)
  command! -nargs=+ -bar CCM call s:core_component(<args>)
  command! -nargs=+ -bar COM call s:optional_component(<args>)
endfunction

function! s:my_plugin(plugin, ...) abort
  if index(g:lbvim.plugins, a:plugin) < 0
    if a:0 == 1
      call plug#(a:plugin, a:1)
      if has_key(a:1, 'defer')
        let l:defer = a:1.defer
        if type(l:defer) == s:type.dict
          if has_key(l:defer, 'delay') && has_key(l:defer, 'callback')
            call timer_start(l:defer.delay, l:defer.callback)
          endif
        endif
      elseif has_key(a:1, 'on_event')
        if type(a:1.on_event) == s:type.list
          let l:group = 'load/' . a:plugin
          let l:plugin_name = split(a:plugin, '/')[1]
          let l:events = join(a:1.on_event, ',')
          let l:load_call = printf("call plug#load('%s')", l:plugin_name)
          execute 'augroup' l:group
          autocmd!
          execute 'autocmd' l:events '*' l:load_call '|' 'autocmd!' l:group
          execute 'augroup END'
        endif
      endif
    else
      call plug#(a:plugin, "")
    endif
  endif
endfunction

function! s:component(name, ...)
  if index(g:lbvim.components_loaded, a:name) == -1
    call add(g:lbvim.components_loaded, a:name)
  endif
endfunction

function! s:core_component(name, ...)
  call s:component('core/' . a:name)
endfunction

function! s:optional_component(name, ...)
  call s:component('opts/' . a:name)
endfunction

function! s:register_plugs()
  silent! if plug#begin(g:lbvim.plugin_home)
    " module init
    if exists('*ModuleInit')
      call ModuleInit()
    endif

    for l:component in g:lbvim.components_loaded
      let l:component_package = g:lbvim.components_dir . '/' . l:component . '/package.vim'
      try
        execute 'so ' . l:component_package
      catch
        return utils#err(v:exception, l:component_package)
      endtry
    endfor

    if exists('*CustomPlug')
      call CustomPlug()
    endif

    call plug#end()
    call s:check_custom_plug()
  endif
endfunction

function! s:register_configs()
  for l:component in g:lbvim.components_loaded
    let l:component_config = g:lbvim.components_dir . '/' . l:component . '/config.vim'
    try
      execute 'so ' . l:component_config
    catch
      return utils#err(v:exception, l:component_config)
    endtry
  endfor
endfunction

function! s:check_custom_file()
  let a:dot_customfile = $HOME . '/.vim.custom'
  if filereadable(expand(a:dot_customfile))
    execute 'so ' . a:dot_customfile
  endif
endfunction

function! s:check_vim_plug()
  if empty(glob(g:lbvim.vim_plug_path))
    execute 'silent !curl -fLo ' . g:lbvim.vim_plug_path . ' --create-dirs ' .
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endfunction

function! s:check_custom_plug()
  " https://github.com/junegunn/vim-plug/wiki/extra#automatically-install-missing-plugins-on-startup
  augroup checkPlug
    autocmd!
    autocmd VimEnter *
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \|   echom 'Some plugins need to install the missing plugins first!'
      \|   PlugInstall --sync | q
      \| endif
  augroup END
endfunction
