setl laststatus=0 noshowmode noruler
augroup fzf
  autocmd!
  autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END