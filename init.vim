" vim: et ts=2 sts=2 sw=2

if !has('nvim')
  finish
endif

let g:nvg_version = 'v2.1'
let g:nvg_root = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let g:nvg_cache_path = expand(g:nvg_root . '/.cache')
let g:nvg_modules = [
      \ 'viminit',
      \ 'theme',
      \ 'startify',
      \ 'mapping',
      \ 'bazel',
      \]
exec 'set rtp+=' . g:nvg_root
call core#run()
