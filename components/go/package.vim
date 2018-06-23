Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
if g:lbvim_isnvim
  Plug 'zchee/deoplete-go', { 'for': 'go', 'build': {'unix': 'make'} }
  Plug 'jodosha/vim-godebug', { 'for': 'go' } " Debugger integration via delve
endif
