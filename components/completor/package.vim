" if g:lbvim_isnvim
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
if g:lbvim_isnvim
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
 " Plug 'roxma/nvim-completion-manager'
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'iliubang/vim-snippets'
