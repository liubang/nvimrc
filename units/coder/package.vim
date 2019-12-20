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
MMP 'rhysd/vim-clang-format', { 'for': ['c', 'cpp', 'proto', 'objc'], 'for_coder': ['clang'] }
MMP 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp', 'lex', 'yacc'], 'for_coder': ['clang'] }
MMP 'sakhnik/nvim-gdb', { 'do': './install.sh', 'for_coder': ['clang'] }
" }}}

" golang
MMP 'fatih/vim-go', { 'for': 'go', 'for_coder': 'go' }
" php
MMP 'StanAngeloff/php.vim', { 'for': ['php'], 'for_coder': ['phplll'] }

