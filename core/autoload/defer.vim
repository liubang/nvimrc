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

" 500
function! defer#editor(timer) abort
  call s:load('fzf.vim', 'vim-surround', 'vim_current_word', 'vim-fugitive')
endfunction

" 600
function! defer#tmux(timer) abort
  call s:load('vim-tmux-focus-events', 'vim-tmux-clipboard')
endfunction

" 700
function! defer#theme(timer) abort
  call s:load('lightline-bufferline', 'vim-highlightedyank')
endfunction

" 800
function! defer#vimpreview(timer) abort
  call s:load('vim-preview')
endfunction
