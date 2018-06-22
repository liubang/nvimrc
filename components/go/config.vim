let g:go_list_type = "quickfix"
let g:go_template_autocreate = 0
let g:go_fmt_autosave = 1
let g:go_fmt_command = "gofmt"
let g:go_doc_command = ["godoc"]
let g:go_snippet_engine = "ultisnips"
let g:go_term_enabled = 1
let g:go_decls_includes = 'func,type'
let g:go_decls_mode = 'fzf'
let g:go_term_mode = "vsplit"

autocmd FileType go nmap <leader>gn :cnext<CR>
autocmd FileType go nmap <leader>gm :cprevious<CR>
autocmd FileType go nmap <leader>ga :cclose<CR>
autocmd FileType go nmap <leader>gc :GoDecls<CR>
autocmd FileType go nmap <leader>gb  <Plug>(go-build)
autocmd FileType go nmap <leader>gr  <Plug>(go-run)
autocmd FileType go nmap <leader>gt  <Plug>(go-test)
autocmd FileType go nmap <leader>gd  <Plug>(go-def)

autocmd FileType go nmap <leader>rt <Plug>(go-run-tab)
autocmd FileType go nmap <Leader>rs <Plug>(go-run-split)
autocmd FileType go nmap <Leader>rv <Plug>(go-run-vertical)
