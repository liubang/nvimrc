"======================================================================
"
" ui.vim - 
"
" Created by liubang on 2020/01/10
" Last Modified: 2020/01/10 17:52:42
"
"======================================================================

" {{{ color mode 
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if g:nvg.tmux
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  if g:nvg.termguicolors
    " fix bug for vim
    set t_8f=^[[38;2;%lu;%lu;%lum
    set t_8b=^[[48;2;%lu;%lu;%lum
    set termguicolors
  else
    set t_Co=256
  endif
  if &ttimeoutlen > 60 || &ttimeoutlen <= 0
    set ttimeoutlen=60
  endif
else
  set ttimeoutlen=20
endif
" }}}

set number
set fillchars+=vert:\|  " add a bar for vertical splits
set fcs=eob:\           " hide ~
set nolist
let SignColumnGuiBg = matchstr(execute('hi SignColumn'), 'guibg=\zs\S*')
exe 'hi GitAdd                guifg=#00FF00 guibg=' . SignColumnGuiBg
exe 'hi GitModify             guifg=#00FFFF guibg=' . SignColumnGuiBg
exe 'hi GitDeleteTop          guifg=#FF2222 guibg=' . SignColumnGuiBg
exe 'hi GitDeleteBottom       guifg=#FF2222 guibg=' . SignColumnGuiBg
exe 'hi GitDeleteTopAndBottom guifg=#FF2222 guibg=' . SignColumnGuiBg
exe 'hi CocHintSign           guifg=#15aabf guibg=' . SignColumnGuiBg
exe 'hi CocInfoSign           guifg=#fab005 guibg=' . SignColumnGuiBg
exe 'hi CocWarningSign        guifg=#ff922b guibg=' . SignColumnGuiBg
exe 'hi CocErrorSign          guifg=#ff0000 guibg=' . SignColumnGuiBg
unlet SignColumnGuiBg

" {{{ lightline & tabline
silent! set laststatus=2   " 总是显示状态栏
silent! set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline
let g:spaceline_seperate_style= 'arrow-fade'
let g:spaceline_colorscheme = 'space'

let g:buffet_tab_icon = "\uf00a"
let g:buffet_show_index = 1
let g:buffet_powerline_separators = 1
let g:buffet_use_devicons = 1
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
""" }}}

" {{{ theme
syntax on
set background=dark
let g:gruvbox_filetype_hi_groups = 1
let g:gruvbox_plugin_hi_groups = 1
let g:gruvbox_transp_bg = 1
" colorscheme gruvbox9_hard
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

" Defx Highlight
highlight Defx_filename_3_Modified  ctermfg=1  guifg=#D370A3
highlight Defx_filename_3_Staged    ctermfg=10 guifg=#A3D572
highlight Defx_filename_3_Ignored   ctermfg=8  guifg=#404660
highlight def link Defx_filename_3_Untracked Comment
highlight def link Defx_filename_3_Unknown Comment
highlight def link Defx_filename_3_Renamed Title
highlight def link Defx_filename_3_Unmerged Label
" }}}

"{{{ startify
let g:webdevicons_enable_startify = 1
let g:startify_custom_header = [
                            \'      ┬  ┬┬ ┬┌┐ ┌─┐┌┐┌┌─┐ ',
                            \'      │  ││ │├┴┐├─┤││││ ┬ ',
                            \'      ┴─┘┴└─┘└─┘┴ ┴┘└┘└─┘ ',
                            \'                          ',
                            \'      Author: liubang <it.liubang@gmail.com> ',
                            \'        Site: https://iliubang.cn            ',
                            \'     Version: ' . g:nvg.version,
                            \'        Vim : ' . utils#get_vim_version(),
                            \ ]

function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction
" }}}

" {{{ quickui
if exists('*nvim_open_win') > 0
  call quickui#menu#reset()
  call quickui#menu#install('&File', [
        \ [ "&Open\t(:e)", 'call feedkeys(":e ")' ],
        \ [ "&Save\t(:w)", 'write' ],
        \ [ "--", ],
        \ [ "File &Explorer", 'Defx', 'Taggle file exporer' ],
        \ [ "Switch &Files", 'Files .' ],
        \ [ "Switch &Buffers", 'call quickui#tools#list_buffer("e")' ],
        \ [ "--", ],
        \ [ "E&xit", 'qa' ],
        \ ])

  call quickui#menu#install('&Edit', [
        \ [ "&Trailing Space", 'call utils#strip_trailing_whitespace()', '' ],
        \ [ "&Find\t", 'Ag', '' ],
        \ [ "F&ormat", 'Format' ],
        \ [ "&Hex Edit", 'Vinarise', 'Ultimate hex editing system with Vim' ],
        \ ])

  call quickui#menu#install('&Build', [
        \ [ "&Compile File\tCtrl-b", 'Build' ],
        \ [ "&E&xecute File\tCtrl-r", 'Run' ],
        \ [ '--','' ],
        \ [ "Clang &Format", 'ClangFormat' ],
        \ ])

  call quickui#menu#install('&Tools', [
        \ [ "View &Diff", 'Gdiffsplit' ], 
        \ [ "Show &Log", 'Gclog' ],
        \ [ "Git &Blame", 'Gblame' ],
        \ [ '--', '' ],
        \ [ "List &Function", 'call quickui#tools#list_function()', '' ],
        \ [ "Display &Messages", 'call quickui#tools#display_messages()', '' ],
        \ [ "&Tagbar", 'Vista!!', '' ],
        \ [ "&Choose Window/Tab", 'ChooseWin', '' ],
        \ [ "Display Ca&lendar", 'Calendar -first_day=monday', '' ],
        \ [ "Ter&minal", 'FloatermToggle', '' ],
        \ [ '--', '' ],
        \ [ "Plugin &Update", 'DeinUpdate', '' ],
        \ ])

  call quickui#menu#install('Help (&?)', [
        \ [ "&Cheatsheet", 'help index', '' ],
        \ [ 'T&ips', 'help tips', '' ],
        \ [ '--','' ],
        \ [ "&Tutorial", 'help tutor', '' ],
        \ [ '&Quick Reference', 'help quickref', '' ],
        \ [ '&Summary', 'help summary', '' ],
        \ [ '--','' ],
        \ [ "&Vim Script", 'help eval', '' ], 
        \ [ "&Function List", 'help function-list', '' ],
        \ ], 10000)
  let g:quickui_color_scheme = 'gruvbox'
  let g:quickui_border_style = 2
  " let g:quickui_show_tip = 1
  " tool bar open
  noremap <silent><Leader>to :call quickui#menu#open()<CR>
  nnoremap <silent><expr><Leader>bb (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') . ":call quickui#tools#list_buffer('e')\<CR>"
endif
" }}}
