"======================================================================
"
" defer.vim - 
"
" Created by liubang on 2018/12/31
" Last Modified: 2018/12/31 15:14:46
"
"======================================================================

function! s:load(...)
  for l:plug in a:000
    silent! call plug#load(l:plug)
  endfor
endfunction

" 400
function! defer#editor(timer) abort
  call s:load('fzf.vim')
  call s:load('vim-surround')
  call s:load('vim_current_word')
  call s:load('vim-fugitive')
endfunction

" 500
function! defer#vimpreview(timer) abort
  call s:load('vim-preview')
endfunction

" 600
function! defer#tmux(timer) abort
  call s:load('vim-tmux-focus-events')
  call s:load('vim-tmux-clipboard')
endfunction
