"======================================================================
"
" dein.vim - 
"
" Created by liubang on 2020/08/09
" Last Modified: 2020/08/09 20:32
"
"======================================================================
let $VIM_PATH = get(g:, 'nvg_root', stdpath('config'))
let $DATA_PATH = expand($VIM_PATH . '/.cache')
let s:toml_files = split(globpath('$VIM_PATH/modules', '*.toml'), '\n')

function! packager#_start()
  if has('vim_starting')
    if has('nvim')
      if !empty($PYTHON3_HOST_PROG)
        let g:python3_host_prog = $PYTHON3_HOST_PROG
      elseif !empty($PYTHON_HOST_PROG)
        let g:python_host_prog = $PYTHON_HOST_PROG
      endif
    endif
  endif
  call s:debin_begin()
endfunc

function s:debin_begin()
  let l:cache_path = $DATA_PATH . '/dein'
  if has('vim_starting')
    " Use dein as a plugin manager
    let g:dein#auto_recache = 0
    let g:dein#install_max_processes = 12
    let g:dein#install_progress_type = 'title'
    let g:dein#enable_notification = 1
    let g:dein#install_log_filename = $DATA_PATH . '/dein.log'
    " Add dein to vim's runtimepath
    if &runtimepath !~# '/dein.vim'
      let s:dein_dir = l:cache_path . '/repos/github.com/Shougo/dein.vim'
      " Clone dein if first-time setup
      if ! isdirectory(s:dein_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
        if v:shell_error
          call s:error('dein installation has failed! is git installed?')
          finish
        endif
      endif
      execute 'set runtimepath+='.substitute(
        \ fnamemodify(s:dein_dir, ':p') , '/$', '', '')
    endif
  endif

  " Initialize dein.vim (package manager)
  if dein#load_state(l:cache_path)
    call dein#begin(l:cache_path, extend([expand('<sfile>')], s:toml_files))
    for l:toml in s:toml_files
      try 
        call dein#load_toml(l:toml)
      catch /.*/
        call utils#errmsg(l:toml . ':' . v:exception)
      endtry
    endfor
    call dein#end()

    " Save cached state for faster startups
    if ! g:dein#_is_sudo
      call dein#save_state()
    endif

    " Update or install plugins if a change detected
    if dein#check_install()
      if ! has('nvim')
        set nomore
      endif
      call dein#install()
    endif
  endif

  filetype plugin indent on
  " Only enable syntax when vim is starting
  if has('vim_starting')
    syntax enable
  endif

  " Trigger source event hooks
  call dein#call_hook('source')
  call dein#call_hook('post_source')
endfunc

command! -nargs=0 -bar PluginUpdate   call dein#update()
command! -nargs=0 -bar ReRuntimePath  call dein#recache_runtimepath()
