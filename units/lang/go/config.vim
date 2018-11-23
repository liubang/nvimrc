"======================================================================
"
" config.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 10:36:46
"
"======================================================================

"----------------------------------------------------------------------
" init
"----------------------------------------------------------------------
function! s:init()
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
  " key 
  nmap <leader>gn :cnext<CR>
  nmap <leader>gm :cprevious<CR>
  nmap <leader>ga :cclose<CR>
  nmap <leader>gc :GoDecls<CR>
  nmap <leader>gb  <Plug>(go-build)
  nmap <leader>gr  <Plug>(go-run)
  nmap <leader>gt  <Plug>(go-test)
  nmap <leader>gd  <Plug>(go-def)
  nmap <leader>rt <Plug>(go-run-tab)
  nmap <Leader>rs <Plug>(go-run-split)
  nmap <Leader>rv <Plug>(go-run-vertical)
endfunc

"----------------------------------------------------------------------
" events
"----------------------------------------------------------------------
autocmd FileType go call s:init()
