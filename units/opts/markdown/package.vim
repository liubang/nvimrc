"======================================================================
"
" package.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 13:01:09
"
"======================================================================
MMP 'mzlogin/vim-markdown-toc', { 'for': ['markdown'] }
if g:lbvim.nvim
  MMP 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
else 
  MMP 'iamcco/mathjax-support-for-mkdp', { 'for': ['markdown'] }
  MMP 'iamcco/markdown-preview.vim', { 'for': ['markdown'] }
endif
