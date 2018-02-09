" Maintainer: liubang <https://github.com/iliubang>
" Version: 0.1
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8

function! defaults#startify#init()
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

endfunction


