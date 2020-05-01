"======================================================================
"
" ui.vim - 
"
" Created by liubang on 2020/01/21
" Last Modified: 2020/01/21 16:30
"
"======================================================================

syntax on

if empty($TMUX) 
  "if has('termguicolors')
    "set termguicolors
  "endif
else
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  if has('termguicolors')
    set t_8f=^[[38;2;%lu;%lu;%lum
    set t_8b=^[[48;2;%lu;%lu;%lum
    set termguicolors
  else
    set t_Co=256
  endif
  if &ttimeoutlen > 60 || &ttimeoutlen <= 0
    set ttimeoutlen=60
  endif
endif

" 退出后清屏
if &term =~ "xterm"
  let &t_ti = "\<Esc>[?47h"
  let &t_te = "\<Esc>[?47l"
endif

set background=dark
set number
set fillchars+=vert:\|  " add a bar for vertical splits
set fcs=eob:\           " hide ~
set nolist

let g:gruvbox_filetype_hi_groups = 1
let g:gruvbox_plugin_hi_groups = 1
let g:gruvbox_transp_bg = 1
let g:gruvbox_material_background = 'soft'
colorscheme gruvbox-material

hi Whitespace ctermfg=96 guifg=#725972 guibg=NONE ctermbg=NONE
hi PMenuSel ctermfg=252 ctermbg=106 guifg=#d0d0d0 guibg=#859900 guisp=#859900 cterm=NONE gui=NONE
hi default CocHighlightText  guibg=#725972 ctermbg=96

"GitGutter Coc-git Highlight
highlight GitGutterAdd ctermfg=22 guifg=#006000 ctermbg=NONE guibg=NONE
highlight GitGutterChange ctermfg=58 guifg=#5F6000 ctermbg=NONE guibg=NONE
highlight GitGutterDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE
highlight GitGutterChangeDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE

highlight Defx_filename_3_Modified  ctermfg=1  guifg=#D370A3
highlight Defx_filename_3_Staged    ctermfg=10 guifg=#A3D572
highlight Defx_filename_3_Ignored   ctermfg=8  guifg=#404660
highlight def link Defx_filename_3_Untracked Comment
highlight def link Defx_filename_3_Unknown Comment
highlight def link Defx_filename_3_Renamed Title
highlight def link Defx_filename_3_Unmerged Label

" floaterm
highlight Floaterm guibg=black
