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

" MMP 'Yggdroot/LeaderF', { 'do': './install.sh' }
MMP 'liuchengxu/vista.vim', { 'on': ['Vista', 'Vista!', 'Vista!!'] }
MMP 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
MMP 'kristijanhusak/defx-icons'
MMP 'kristijanhusak/defx-git'
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
MMP $ZPLUG_HOME . '/repos/junegunn/fzf'
" MMP 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
MMP 'junegunn/fzf.vim'
MMP 'tpope/vim-surround'
MMP 'dominikduda/vim_current_word'
MMP 'tpope/vim-fugitive'
MMP 'terryma/vim-expand-region'
