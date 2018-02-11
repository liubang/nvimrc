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