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
  nnoremap <silent><buffer><leader>gn :cnext<cr>
  nnoremap <silent><buffer><leader>gm :cprevious<cr>
  nnoremap <silent><buffer><leader>ga :cclose<cr>
  nnoremap <silent><buffer><leader>gc :GoDecls<cr>
  nmap <silent><buffer><leader>gb <plug>(go-build)
  nmap <silent><buffer><leader>gr <plug>(go-run)
  nmap <silent><buffer><leader>gt <plug>(go-test)
  nmap <silent><buffer><leader>gd <plug>(go-def)
  nmap <silent><buffer><leader>rt <plug>(go-run-tab)
  nmap <silent><buffer><leader>rs <plug>(go-run-split)
  nmap <silent><buffer><leader>rv <plug>(go-run-vertical)
endfunction

"----------------------------------------------------------------------
" events
"----------------------------------------------------------------------

if !g:lbvim.use_lsp
  autocmd FileType go call s:init()
endif
