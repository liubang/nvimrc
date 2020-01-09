"======================================================================
"
" package.vim - 
"
" Created by liubang on 2019/11/17
" Last Modified: 2019/11/17 00:20:50
"
"======================================================================

" {{{ lsp
call dein#add('honza/vim-snippets')
call dein#add('neoclide/coc.nvim', {'rev': 'release'})
call dein#add('neoclide/jsonc.vim', {'on_ft': ['json', 'jsonc']})
" }}}

" {{{ c/c++ 
call dein#add('rhysd/vim-clang-format', {'on_ft': ['c', 'cpp', 'proto', 'objc']})
call dein#add('octol/vim-cpp-enhanced-highlight', {'on_ft': ['c', 'cpp', 'lex', 'yacc']})
call dein#add('sakhnik/nvim-gdb', {'build': 'sh install.sh', 'on_ft': ['c', 'cpp']})
" }}}

" golang
call dein#add('fatih/vim-go', {'on_ft': ['go']})
" php
call dein#add('StanAngeloff/php.vim', {'on_ft': ['php']})
