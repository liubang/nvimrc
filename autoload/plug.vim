" vim: et ts=2 sts=2 sw=2

let s:cache_path = get(g:, 'nvg_cache_path', $HOME . '/.cache')

function! plug#init() abort		
  if &runtimepath !~# '/dein.vim'
    let dein_dir = s:cache_path . '/repos/github.com/Shougo/dein.vim'  
    if !isdirectory(dein_dir)
      exec '!git clone https://github.com/Shougo/dein.vim ' . dein_dir
      if v:shell_error
        //TODO 
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
