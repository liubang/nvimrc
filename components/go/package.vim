MMP 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
if g:lbvim_isnvim
  MMP 'zchee/deoplete-go', { 'for': 'go', 'build': {'unix': 'make'} }
  MMP 'jodosha/vim-godebug', { 'for': 'go' } " Debugger integration via delve
endif
