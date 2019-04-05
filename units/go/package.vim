"======================================================================
"
" package.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 13:00:53
"
"======================================================================
if !g:lbvim.use_lsp
  MMP 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
  if g:lbvim.nvim
    MMP 'zchee/deoplete-go', { 'for': 'go', 'build': {'unix': 'make'} }
    MMP 'jodosha/vim-godebug', { 'for': 'go' } " Debugger integration via delve
  endif
endif
