if has("termguicolors")
  " fix bug for vim
  set t_8f=^[[38;2;%lu;%lu;%lum
  set t_8b=^[[48;2;%lu;%lu;%lum

  " enable true color
  set termguicolors
else
  set t_Co=256
endif

set laststatus=2
set background=dark
colorscheme yadracula
let g:yadracula_contrast='hard'
let g:yadracula_contrast_dark='hard'

" startify
let g:vim#startify#header = [
                            \'      ┬  ┬┬ ┬┌┐ ┌─┐┌┐┌┌─┐ ',
                            \'      │  ││ │├┴┐├─┤││││ ┬ ',
                            \'      ┴─┘┴└─┘└─┘┴ ┴┘└┘└─┘ ',
                            \'													',
                            \'      Author: liubang <it.liubang@gmail.com> ',
                            \'        Site: https://iliubang.github.io     ',
                            \'     Version: ' . g:lbvim_version,
                            \	]
let g:vim#startify#order = [
                \ ['   Recent Files:'],
                \ 'files',
                \ ['   Project:'],
                \ 'dir',
                \ ['   Sessions:'],
                \ 'sessions',
                \ ['   Bookmarks:'],
                \ 'bookmarks',
                \ ['   Commands:'],
                \ 'commands',
                \ ]
                
let g:startify_custom_header = g:vim#startify#header
let g:startify_list_order = g:vim#startify#order
let g:startify_change_to_vcs_root = 1
