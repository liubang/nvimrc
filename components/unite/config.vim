" Maintainer: liubang <https://github.com/iliubang>
" Version: 0.1
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8

nnoremap <C-p> :Unite file_rec/async<cr>
nnoremap <Leader>/ :Unite grep:.<cr>
nnoremap <Leader>s :Unite -quick-match buffer<cr>