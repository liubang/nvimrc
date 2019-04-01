"======================================================================
"
" package.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 13:00:38
"
"======================================================================
MMP 'easymotion/vim-easymotion', { 'on': [
      \ '<Plug>(easymotion-lineforward)',
      \ '<Plug>(easymotion-j)',
      \ '<Plug>(easymotion-k)',
      \ '<Plug>(easymotion-linebackward)',
      \ '<Plug>(easymotion-bd-w)',
      \ '<Plug>(easymotion-overwin-w)'
      \ ] }

MMP 'jiangmiao/auto-pairs', { 'on': [] }
augroup lbvimAutoPairs
  autocmd!
  autocmd CursorHold,CursorHoldI,InsertEnter, * call plug#load('auto-pairs') 
        \ | call AutoPairsTryInit() 
        \ | autocmd! lbvimAutoPairs
augroup END

" MMP 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
" MMP 'liuchengxu/vista.vim', { 'on': ['Vista', 'Vista!', 'Vista!!'] }
MMP 'Yggdroot/LeaderF', { 'do': './install.sh' }
MMP 'liuchengxu/vista.vim', { 'on': ['Vista', 'Vista!', 'Vista!!'] }
MMP 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins', 'on': ['Defx'] }
MMP 'kana/vim-textobj-user'
MMP 'kana/vim-textobj-function', { 'for': ['c', 'cpp', 'vim', 'java', 'php'] }
MMP 'sgur/vim-textobj-parameter', { 'for': ['c', 'cpp', 'vim', 'java', 'php'] }
MMP 'skywind3000/asyncrun.vim', { 'on': ['AsyncRun', 'AsyncRun!'] }

MMP 'junegunn/vim-easy-align', { 'on': [ 'EasyAlign', '<Plug>(EasyAlign)' ] }
MMP 'junegunn/gv.vim', { 'on': 'GV' }
MMP 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }
MMP 'Shougo/vinarise.vim', { 'on': 'Vinarise' }

" multi cursors
MMP 'mg979/vim-visual-multi'

" fzf
MMP 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" {{{ defer#editor 
MMP 'junegunn/fzf.vim', { 'on': [] }
MMP 'tpope/vim-surround', { 'on': [] }
MMP 'dominikduda/vim_current_word', { 'on': [] }
MMP 'tpope/vim-fugitive', { 'on': [] , 'defer': {'delay': 500, 'callback': 'defer#editor'}}
" }}}

