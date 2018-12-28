"======================================================================
"
" config.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 10:37:26
"
"======================================================================

"----------------------------------------------------------------------
" init
"----------------------------------------------------------------------
function! s:init()
  let g:jedi#popup_select_first=1
  set completeopt=longest,menuone
  let g:jedi#auto_vim_configuration = 0
  let g:jedi#popup_on_dot = 0
  let g:jedi#show_call_signatures = "0"   " 补全时不弹出函数的参数列表框
  let g:jedi#auto_initialization = 0

  " Syntax
  let g:python_highlight_all = 1

  " Folding
  let g:coiled_snake_foldtext_flags = []

  " Use Braceless for
  " - indents
  " - text objects (indent blocks ii, ai)
  let g:braceless_block_key = 'i'
endfun

"----------------------------------------------------------------------
" events
"----------------------------------------------------------------------
augroup PythonGroup
  autocmd!
  autocmd FileType python call s:init()
  autocmd FileType python BracelessEnable +indent
augroup END

