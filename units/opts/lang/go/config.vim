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
  let g:go_term_width = 60

  " key mapping
  call utils#map("n", "<leader>gn", ":cnext")
  call utils#map("n", "<leader>gm", ":cprevious")
  call utils#map("n", "<leader>ga", ":cclose")
  call utils#map("n", "<leader>gc", ":GoDecls")
  call utils#map("n", "<leader>gb", "<plug>(go-build)")
  call utils#map("n", "<leader>gr", "<plug>(go-run)")
  call utils#map("n", "<leader>gt", "<plug>(go-test)")
  call utils#map("n", "<leader>gd", "<plug>(go-def)")
  call utils#map("n", "<leader>rt", "<plug>(go-run-tab)")
  call utils#map("n", "<leader>rs", "<plug>(go-run-split)")
  call utils#map("n", "<leader>rv", "<plug>(go-run-vertical)")

endfunction

"----------------------------------------------------------------------
" events
"----------------------------------------------------------------------
autocmd FileType go call s:init()
