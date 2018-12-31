"======================================================================
"
" package.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 13:00:25
"
"======================================================================

if g:lbvim.nvim
  MMP 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  MMP 'Shougo/deoplete.nvim'
  MMP 'roxma/nvim-yarp'
  MMP 'roxma/vim-hug-neovim-rpc'
endif

MMP 'Shougo/neosnippet.vim', { 'on': [] , 'on_event': ['InsertEnter']}
MMP 'Shougo/neosnippet-snippets', { 'on': [] , 'on_event': ['InsertEnter']}
