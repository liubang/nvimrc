silent! setl laststatus=0 
silent! setl listchars=
augroup fzf
  autocmd!
  autocmd BufLeave <buffer> set laststatus=2 
augroup END
