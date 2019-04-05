"======================================================================
"
" package.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 13:01:19
"
"======================================================================

if !g:lbvim.use_lsp
  MMP 'davidhalter/jedi-vim', { 'for': 'python' }
  MMP 'zchee/deoplete-jedi', { 'for': 'python' }
  MMP 'vim-python/python-syntax', { 'for': 'python' }
  MMP 'kalekundert/vim-coiled-snake', { 'for': 'python' }  " Folding
  MMP 'tweekmonster/braceless.vim', { 'for': 'python' }    " Indents
  MMP 'jeetsukumaran/vim-pythonsense', { 'for': 'python' } " Text objects and motions
  MMP 'sillybun/autoformatpythonstatement', { 'do': './install.sh', 'for': 'python' }
endif
