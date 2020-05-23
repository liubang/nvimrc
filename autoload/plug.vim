"======================================================================
"
" plug.vim - 
"
" Created by liubang on 2020/01/21
" Last Modified: 2020/01/21 16:36
"
"======================================================================

let s:cache_path = get(g:, 'nvg_cache_path', $HOME . '/.cache')
let s:dein_url = 'https://github.com/Shougo/dein.vim'
let s:toml = g:nvg_root. '/plugins.toml'
let s:lazy_toml = g:nvg_root. '/plugins_lazy.toml'

function! s:plug_manager_init() abort		
  if &runtimepath !~# '/dein.vim'
    let dein_dir = s:cache_path . '/repos/github.com/Shougo/dein.vim'  
    let g:dein#auto_recache = 0
		let g:dein#install_max_processes = 12
		let g:dein#install_progress_type = 'title'
		let g:dein#enable_notification = 0
    if !isdirectory(dein_dir)
      exec '!git clone ' . s:dein_url . ' ' . dein_dir
      autocmd VimEnter * call dein#install() | source $MYVIMRC
      if v:shell_error
        call utils#errmsg('
              \ dein installation has failed! is git installed?')
      endif
    endif
    exec 'set runtimepath+=' . substitute(
          \ fnamemodify(dein_dir, ':p'), 
          \ '/$', '', '')
  endif
endfunc

function! s:plug_load() abort
  if dein#load_state(s:cache_path) 
    call dein#begin(s:cache_path, [ 
          \ expand('<sfile>'), 
          \ s:toml, 
          \ s:lazy_toml
          \ ])

    call dein#load_toml(s:toml, {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    call dein#end()
    call dein#save_state()
    if dein#check_install()
      call dein#install()
    endif
  endif
  filetype plugin indent on
  syntax enable
  " Trigger source event hooks
  call dein#call_hook('source')
  call dein#call_hook('post_source')
endfunc

function! plug#init() abort
  call s:plug_manager_init()
  call s:plug_load()
endfunc
