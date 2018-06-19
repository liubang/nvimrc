let g:go_list_type = "quickfix"

autocmd FileType go nmap <leader>n :cnext<CR>
autocmd FileType go nmap <leader>m :cprevious<CR>
autocmd FileType go nmap <leader>a :cclose<CR>
autocmd FileType go nmap <leader>b  <Plug>(go-build)
"autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>r :GoRun %<CR>
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>d  <Plug>(go-def)

autocmd FileType go nmap <leader>rt <Plug>(go-run-tab)
autocmd FileType go nmap <Leader>rs <Plug>(go-run-split)
autocmd FileType go nmap <Leader>rv <Plug>(go-run-vertical)
