if !g:lbvim_isnvim
  MMP 'Shougo/deoplete.nvim', { 'do': ':UpdateRemoteMMPins' }
  MMP 'roxma/nvim-yarp'
  MMP 'roxma/vim-hug-neovim-rpc'
else
  MMP 'Shougo/deoplete.nvim'
endif

MMP 'ervandew/supertab'
MMP 'SirVer/ultisnips'
MMP 'iliubang/vim-snippets'

" for viml
MMP 'Shougo/neco-vim', { 'for': 'vim' }
