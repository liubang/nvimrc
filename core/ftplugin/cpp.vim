"setlocal cindent tabstop=4 shiftwidth=4 softtabstop=4
" let b:SuperTabDisabled = 1
setlocal expandtab cindent cino=j1,(0,ws,Ws

command! -bang -nargs=0 Build
      \ :AsyncRun -cwd=$(VIM_FILEDIR) -raw g++ -std=c++11 -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"

command! -bang -nargs=? BuildArgs
      \ :AsyncRun -cwd=$(VIM_FILEDIR) -raw g++ <args> "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"
