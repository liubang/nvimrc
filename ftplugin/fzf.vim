setl laststatus=0 noshowmode noruler
setl listchars=
augroup fzf
  autocmd!
  autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END
