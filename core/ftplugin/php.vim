setlocal cindent expandtab tabstop=4 shiftwidth=4 softtabstop=4

" let b:SuperTabDisabled = 1
command! -bang -nargs=0 Run
      \ :AsyncRun -cwd=$(VIM_FILEDIR) -raw php $(VIM_FILEPATH)

command! -bang -nargs=0 Build
      \ :AsyncRun -cwd=<root> -raw composer --optimize-autoloader update
