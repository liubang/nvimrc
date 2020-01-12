silent! setl laststatus=0 noshowmode noruler nonumber norelativenumber
" Clear the message
echo "\r"
augroup fzf
  autocmd!
  autocmd BufLeave <buffer> set laststatus=2 
augroup END
