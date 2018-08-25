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
