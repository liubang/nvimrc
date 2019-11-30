"======================================================================
"
" package.vim - 
"
" Created by liubang on 2019/11/17
" Last Modified: 2019/11/17 00:20:50
"
"======================================================================

" {{{ lsp
MMP 'honza/vim-snippets'
MMP 'neoclide/coc.nvim', {'branch': 'release'}
MMP 'neoclide/jsonc.vim', { 'for': ['json', 'jsonc'] }
" }}}

" {{{ c/c++ 
MMP 'rhysd/vim-clang-format', { 'for': ['c', 'cpp', 'proto', 'objc'] }
MMP 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp', 'lex', 'yacc'] }
MMP 'sakhnik/nvim-gdb', { 'do': './install.sh' }
" }}}

" {{{ golang
MMP 'fatih/vim-go', { 'for': 'go'  }
" }}}

