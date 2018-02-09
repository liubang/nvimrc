" Maintainer: liubang <https://github.com/iliubang>
" Version: 0.1
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8

function! defaults#theme#init()
    " about theme {{{
    set t_Co=256
    set laststatus=2
    set background=dark
    colorscheme yadracula
    let g:yadracula_contrast='hard'
    let g:yadracula_contrast_dark='hard'
    " }}}
endfunction
