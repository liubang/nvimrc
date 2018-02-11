let $LANG = 'en_US'
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

nmap <Leader>? <plug>(fzf-maps-n)
xmap <Leader>? <plug>(fzf-maps-x)
omap <Leader>? <plug>(fzf-maps-o)
nnoremap <Leader>ag :Ag<CR>
nnoremap <Leader>bb :Buffers<CR>
nnoremap <Leader>b? :Buffers<CR>
nnoremap <Leader>w? :Windows<CR>
nnoremap <Leader>f? :FZF ~<CR>
nnoremap <Leader>ff :FZF<CR>