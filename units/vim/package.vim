"======================================================================
"
" package.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 13:00:19
"
"======================================================================
if g:lbvim.tmux
  MMP 'tmux-plugins/vim-tmux-focus-events'
  MMP 'roxma/vim-tmux-clipboard'
endif

if g:lbvim.use_lsp
  autocmd FileType vim let b:coc_pairs_disabled = ['"']
endif
