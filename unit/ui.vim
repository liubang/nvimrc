" vim: et ts=2 sts=2 sw=2

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

silent! set laststatus=2   " 总是显示状态栏
silent! set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline
let g:spaceline_seperate_style= 'arrow-fade'
let g:spaceline_colorscheme = 'space'
let g:spaceline_line_symbol = 1
" buffet
let g:buffet_always_show_tabline = 1
if has('macunix')
  let g:buffet_tab_icon = "\uf302"
elseif has('unix') && !has('macunix') && !has('win32unix')
  let g:buffet_tab_icon = "\uf17c"
endif
let g:buffet_show_index = 1
let g:buffet_powerline_separators = 1
let g:buffet_use_devicons = 0
nmap <silent> <expr> <Leader>1 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>BuffetSwitch(1)"
nmap <silent> <expr> <Leader>2 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>BuffetSwitch(2)"
nmap <silent> <expr> <Leader>3 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>BuffetSwitch(3)"
nmap <silent> <expr> <Leader>4 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>BuffetSwitch(4)"
nmap <silent> <expr> <Leader>5 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>BuffetSwitch(5)"
nmap <silent> <expr> <Leader>6 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>BuffetSwitch(6)"
nmap <silent> <expr> <Leader>7 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>BuffetSwitch(7)"
nmap <silent> <expr> <Leader>8 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>BuffetSwitch(8)"
nmap <silent> <expr> <Leader>9 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>BuffetSwitch(9)"
nmap <silent> <expr> <Leader>0 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>BuffetSwitch(10)"

function! g:BuffetSetCustomColors()
  hi! BuffetCurrentBuffer cterm=NONE ctermbg=214 ctermfg=239 guibg=#b8bb26 guifg=#000000
  hi! BuffetTrunc cterm=bold ctermbg=239 ctermfg=7 guibg=#458588 guifg=#000000
  hi! BuffetBuffer cterm=NONE ctermbg=239 ctermfg=7 guibg=#504945 guifg=#000000
  hi! BuffetActiveBuffer cterm=NONE ctermbg=239 ctermfg=7 guibg=#999999 guifg=#504945
  hi! BuffetTab cterm=NONE ctermbg=8 ctermfg=15 guibg=#458588 guifg=#000000
endfunction

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

let g:webdevicons_enable_startify = 1
let g:startify_custom_header = [
                            \'      ┬  ┬┬ ┬┌┐ ┌─┐┌┐┌┌─┐ ',
                            \'      │  ││ │├┴┐├─┤││││ ┬ ',
                            \'      ┴─┘┴└─┘└─┘┴ ┴┘└┘└─┘ ',
                            \'                          ',
                            \'      Author: liubang <it.liubang@gmail.com> ',
                            \'        Site: https://iliubang.cn            ',
                            \'     Version: ' . g:nvg_version,
                            \'        Vim : ' . utils#get_vim_version(),
                            \ ]

function! StartifyEntryFormat()
  return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction
