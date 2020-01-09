"======================================================================
"
" package.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 13:01:09
"
"======================================================================
call dein#add('mzlogin/vim-markdown-toc', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd']})
call dein#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
					\ 'build': 'cd app & yarn install' })
