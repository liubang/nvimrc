setlocal expandtab cindent tabstop=4 shiftwidth=4 softtabstop=4
" let b:SuperTabDisabled = 1

command! -bang -nargs=0 Build
      \ :AsyncRun -cwd=$(VIM_FILEDIR) -raw gcc -std=c99 -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"

command! -bang -nargs=? BuildArgs
      \ :AsyncRun -cwd=$(VIM_FILEDIR) -raw gcc <args> "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"
