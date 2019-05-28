"======================================================================
"
" package.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 13:00:11
"
"======================================================================
MMP 'rhysd/vim-clang-format', { 'for': ['c', 'cpp'] }
MMP 'google/vim-maktaba', { 'for': ['bzl'] }
MMP 'bazelbuild/vim-bazel', { 'for': ['bzl'] }
if !g:lbvim.use_lsp
  MMP 'Shougo/neoinclude.vim', { 'for': ['c', 'cpp'] }
  MMP 'Shougo/deoplete-clangx', { 'for': ['c', 'cpp'] }
  MMP 'rhysd/vim-llvm', { 'for': ['c', 'cpp'] }
  MMP 'justinmk/vim-syntax-extra',{'for': ['c', 'cpp', 'lex', 'yacc']}
endif
