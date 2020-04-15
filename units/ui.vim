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
silent! set laststatus=2   " 总是显示状态栏
silent! set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline

" lightline and tabline
let g:lightline = {
      \ 'colorscheme': 'gruvbox_material',
      \ 'active': {
      \   'left': [ ['homemode'],
      \             ['gitbranch', 'gitstatus'], ['filename'], ['cocerror'], ['cocwarn'] ],
      \   'right': [ ['linenumber'], 
      \              ['linepercent'], ['fileformat', 'encoding'] ],
      \ },
      \ 'inactive': {
      \   'left': [['homemode'], ['filename']],
      \   'right': [['linenumber'], ['linepercent']],
      \ },
      \ 'tabline': {
      \   'left': [['buffers']],
      \   'right': [['sign']],
      \ },
      \ 'component': {
      \   'sign': "\uf25b",
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers',
      \ },
      \ 'component_function': {
      \   'linenumber': 'LightLineLineinfo',
      \   'linepercent': 'LightLinePercent',
      \   'homemode': 'LightLineHomeMode',
      \   'cocerror': 'LightLineCocError',
      \   'cocwarn' : 'LightLineCocWarn',
      \   'gitbranch': 'LightLineGitBranch',
      \   'gitstatus': 'LightLineGitStatus',
      \   'readonly': 'LightLineReadonly',
      \   'modified': 'LightLineModified',
      \   'filename': 'LightLineFname',
      \   'filetype': 'LightLineFiletype',
      \   'fileformat': 'LightLineFileformat',
      \   'encoding': 'LightLineEncoding',
      \ },
      \ 'component_type': {'buffers': 'tabsel'},
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2"},
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3"}
      \ }

function! s:isSpecial() abort
    return &buftype =~ '\v(terminal|quickfix)' || &filetype =~ '\v(help|startify|defx|vista|undotree|SpaceVimPlugManager)'
endfunc

function! LightLineEncoding() 
  if s:isSpecial()
    return ''
  endif
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunc

function! LightLineLineinfo() 
  if s:isSpecial() 
    return ""
  endif
  return ' ' . line('.').':'. col('.')
endfunc

function! LightLinePercent() 
  if s:isSpecial()
    return ''
  endif
  return line('.') * 100 / line('$') . '%'
endfunc

function! LightLineHomeMode()
  if &buftype == 'terminal'
    return toupper(&buftype)
  elseif &buftype == 'quickfix'
    return toupper(&buftype)
  elseif s:isSpecial() 
    return toupper(&filetype)
  else
    let nr = s:get_buffer_number()
    let nmap = [ '⓿ ',  '❶ ',  '❷ ',  '❸ ', '❹ ','❺ ',  '❻ ',  '❼ ',  '❽ ',  '❾ ','➓ ','⓫ ','⓬ ','⓭ ','⓮ ','⓯ ','⓰ ','⓱ ','⓲ ','⓳ ','⓴ ']
    if nr == 0
      return ''
    endif
    let l:number = nr
    let l:result = ''
    for i in range(1, strlen(l:number))
      let l:result = get(nmap, l:number % 10, l:number % 10) . l:result
      let l:number = l:number / 10
    endfor
    return join(['🌈',l:result])
  endif
endfunction

function! s:get_buffer_number()
  let i = 0
  for nr in filter(range(1, bufnr('$')), 'bufexists(v:val) && buflisted(v:val)')
    let i += 1
    if nr == bufnr('')
      return i
    endif
  endfor
  return ''
endfunction

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "\uf023"
  else
    return ""
  endif
endfunction

function! LightLineGitBranch()
  if s:isSpecial()
    return ""
  endif
  return get(g:, 'coc_git_status', '')
endfunction

function! LightLineGitStatus()
  if s:isSpecial()
    return ''
  endif
  return get(b:, 'coc_git_status', '')
endfunction

function! LightLineCocError()
  let error_sign = get(g:, 'coc_status_error_sign', "\uf00d ")
  let info = get(b:, 'coc_diagnostic_info', {})
  if !empty(info) && get(info, 'error')
    return error_sign . info['error']
  endif
  return ''
endfunction

function! LightLineCocWarn() abort
  let warning_sign = get(g:, 'coc_status_warning_sign', "\uf12a ")
  let info = get(b:, 'coc_diagnostic_info', {})
  if !empty(info) && get(info, 'warning')
    return warning_sign . info['warning']
  endif
  return ''
endfunction

function! LightLineFname() 
  if s:isSpecial()
    return ''
  endif
  let icon = (strlen(&filetype) ? ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') 
  let filename = LightLineFilename()
  let ret = [filename,icon]
  if filename == ''
    return ''
  endif
  return join([filename, icon],'')
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != expand('%:t') ? expand('%:t') : '') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightLineFileformat()
  if s:isSpecial() || winwidth(0) <= 70
    return ''
  endif
  return &fileformat . ' ' . WebDevIconsGetFileFormatSymbol()
endfunction

autocmd User CocDiagnosticChange call lightline#update()

let g:lightline#bufferline#show_number  = 2
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#unnamed      = '[No Name]'
let g:lightline#bufferline#number_map = {
      \ 0: '⓿ ', 1: '❶ ', 2: '❷ ', 3: '❸ ', 4: '❹ ',
      \ 5: '❺ ', 6: '❻ ', 7: '❼ ', 8: '❽ ', 9: '❾ '}

nmap <silent> <expr> <Leader>1 (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(1)"
nmap <silent> <expr> <Leader>2 (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(2)"
nmap <silent> <expr> <Leader>3 (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(3)"
nmap <silent> <expr> <Leader>4 (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(4)"
nmap <silent> <expr> <Leader>5 (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(5)"
nmap <silent> <expr> <Leader>6 (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(6)"
nmap <silent> <expr> <Leader>7 (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(7)"
nmap <silent> <expr> <Leader>8 (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(8)"
nmap <silent> <expr> <Leader>9 (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(9)"
nmap <silent> <expr> <Leader>0 (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(10)"
""" }}}

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

" starify
let g:webdevicons_enable_startify = 1
let g:startify_files_number = 8
let g:startify_enable_special = 0
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
autocmd User Startified setlocal buflisted

function! StartifyEntryFormat()
  return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction
