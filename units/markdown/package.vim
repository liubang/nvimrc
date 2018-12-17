"======================================================================
"
" package.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 13:01:09
"
"======================================================================
MMP 'fszymanski/deoplete-emoji', { 'for': ['markdown', 'gitcommit'] }
if g:IS_NVIM
  MMP 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
else 
  MMP 'iamcco/mathjax-support-for-mkdp', { 'for': ['markdown', 'md'] }
  MMP 'iamcco/markdown-preview.vim', { 'for': ['markdown', 'md'] }
endif
