"======================================================================
"
" plug.vim - 
"
" Created by liubang on 2020/01/21
" Last Modified: 2020/01/21 16:36
"
"======================================================================

let s:cache_path = get(g:, 'nvg_cache_path', $HOME . '/.cache')

function! plug#init() abort		
  if &runtimepath !~# '/dein.vim'
    let dein_dir = s:cache_path . '/repos/github.com/Shougo/dein.vim'  
    if !isdirectory(dein_dir)
      exec '!git clone https://github.com/Shougo/dein.vim ' . dein_dir
      autocmd VimEnter * call dein#install() | source $MYVIMRC
      if v:shell_error
        call utils#errmsg('dein installation has failed! is git installed?')
      endif
    endif
    exec 'set runtimepath+=' . substitute(fnamemodify(dein_dir, ':p'), '/$', '', '')
  endif
endfunc

function! plug#load(path) abort
  if dein#load_state(s:cache_path) 
    call dein#begin(s:cache_path)
    exec 'so ' . a:path
    call dein#end()
    call dein#save_state()
    if dein#check_install()
      call dein#install()
    endif
  endif
endfunc
