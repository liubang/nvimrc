"======================================================================
"
" package.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 13:00:25
"
"======================================================================

if !g:IS_NVIM
  MMP 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  MMP 'roxma/nvim-yarp'
  MMP 'roxma/vim-hug-neovim-rpc'
else
  MMP 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif

" MMP 'SirVer/ultisnips'
" MMP 'iliubang/vim-snippets'
MMP 'Shougo/neosnippet.vim'
MMP 'Shougo/neosnippet-snippets'

