"======================================================================
"
" plugins.vim - 
"
" Created by liubang on 2020/01/10
" Last Modified: 2020/01/10 17:06:54
"
"======================================================================
call dein#add('tmux-plugins/vim-tmux-focus-events', {'on_if': 'g:nvg.tmux > 0'})
call dein#add('roxma/vim-tmux-clipboard', {'on_if': 'g:nvg.tmux > 0'})

call dein#add('posva/vim-vue', {'on_ft': ['html', 'vue']})
call dein#add('machakann/vim-highlightedyank')
call dein#add('mhinz/vim-startify')
call dein#add('hardcoreplayers/spaceline.vim')
call dein#add('ryanoasis/vim-devicons')
call dein#add('bagrat/vim-buffet')
call dein#add('sainnhe/gruvbox-material', {'rev': 'neosyn'})

call dein#add('mzlogin/vim-markdown-toc', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd']})
call dein#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
					\ 'build': 'cd app & yarn install' })

call dein#add('easymotion/vim-easymotion')
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
call dein#add('t9md/vim-choosewin', {'on_cmd': ['ChooseWin']})
call dein#add('tpope/vim-surround')
call dein#add('itchyny/calendar.vim', {'on_cmd': ['Calendar']})
call dein#add('dominikduda/vim_current_word')
call dein#add('terryma/vim-expand-region')
call dein#add('Yggdroot/indentLine', {'on_ft': ['python', 'html', 'vim', 'lua', 'yaml']})
call dein#add('google/vim-maktaba')
call dein#add('bazelbuild/vim-bazel')
call dein#add('skywind3000/vim-quickui')
call dein#add('skywind3000/asyncrun.vim', {'on_cmd': ['AsyncRun', 'AsyncRun!']})

call dein#add('neoclide/coc.nvim', {'merged':0, 'build': 'yarn install --frozen-lockfile'})
call dein#add('honza/vim-snippets')
call dein#add('neoclide/jsonc.vim', {'on_ft': ['json', 'jsonc']})

call dein#add('rhysd/vim-clang-format', {'on_ft': ['c', 'cpp', 'proto', 'objc']})
call dein#add('octol/vim-cpp-enhanced-highlight', {'on_ft': ['c', 'cpp', 'lex', 'yacc']})
call dein#add('sakhnik/nvim-gdb', {'build': 'sh install.sh', 'on_ft': ['c', 'cpp']})

call dein#add('fatih/vim-go', {'on_ft': ['go']})
call dein#add('StanAngeloff/php.vim', {'on_ft': ['php']})
