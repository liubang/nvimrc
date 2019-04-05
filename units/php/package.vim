"======================================================================
"
" package.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 13:01:14
"
"======================================================================

if !g:lbvim.use_lsp
  MMP '2072/PHP-Indenting-for-VIm', { 'for': 'php' }
  MMP 'StanAngeloff/php.vim', { 'for': 'php' }
  MMP 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer update' }
  MMP 'lvht/phpfold.vim', { 'for': 'php', 'do': 'composer update' }
endif
