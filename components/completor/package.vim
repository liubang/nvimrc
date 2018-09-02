if !g:lbvim_isnvim
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
else
  Plug 'Shougo/deoplete.nvim'
endif

Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'iliubang/vim-snippets'

" for viml
Plug 'Shougo/neco-vim', { 'for': 'vim' }
