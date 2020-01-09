"======================================================================
"
" package.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 13:00:38
"
"======================================================================
call dein#add('easymotion/vim-easymotion', {'on_func': [ 
      \ '<Plug>(easymotion-lineforward)',
      \ '<Plug>(easymotion-j)',
      \ '<Plug>(easymotion-k)',
      \ '<Plug>(easymotion-linebackward)',
      \ '<Plug>(easymotion-bd-w)',
      \ '<Plug>(easymotion-overwin-w)'
      \ ]})
call dein#add('liuchengxu/vista.vim', {'on_cmd': ['Vista', 'Vista!', 'Vista!!']})
call dein#add('Shougo/defx.nvim')
call dein#add('kristijanhusak/defx-icons')
call dein#add('kristijanhusak/defx-git')
call dein#add('kana/vim-textobj-user')
call dein#add('kana/vim-textobj-function')
call dein#add('sgur/vim-textobj-parameter')
call dein#add('junegunn/vim-easy-align', {'on_cmd': ['EasyAlign']})
" for git
call dein#add('tpope/vim-fugitive')
" binary editor
call dein#add('Shougo/vinarise.vim', {'on_cmd': 'Vinarise'})
" multi cursors
call dein#add('mg979/vim-visual-multi')
" fzf
call dein#add('junegunn/fzf', {'build': './install --all', 'merged': 0}) 
call dein#add('junegunn/fzf.vim', {'depends': 'fzf'})
call dein#add('tpope/vim-surround')
call dein#add('dominikduda/vim_current_word')
call dein#add('terryma/vim-expand-region')
call dein#add('Yggdroot/indentLine', {'on_ft': ['python', 'html', 'vim', 'lua', 'yaml']})
call dein#add('google/vim-maktaba')
call dein#add('bazelbuild/vim-bazel')
call dein#add('skywind3000/vim-quickui')
call dein#add('skywind3000/asyncrun.vim', {'on_cmd': ['AsyncRun', 'AsyncRun!']})
