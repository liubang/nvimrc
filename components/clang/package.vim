" if g:lbvim_isnvim
"    Plug 'roxma/ncm-clang'
" endif
Plug 'rhysd/vim-clang-format', { 'for': ['c', 'cpp'] }
Plug 'Shougo/neoinclude.vim', { 'for': ['c', 'cpp'] }
Plug 'Shougo/deoplete-clangx', { 'for': ['c', 'cpp'] }
Plug 'rhysd/vim-llvm', { 'for': ['c', 'cpp'] }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'for': ['c', 'cpp'],
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
