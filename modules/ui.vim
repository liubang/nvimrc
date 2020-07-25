" colorscheme
if !empty($TMUX) 
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
" hi PMenuSel ctermfg=252 ctermbg=106 guifg=#d0d0d0 guibg=#859900 guisp=#859900 cterm=NONE gui=NONE

" lightline
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

function! LightLineEncoding() 
  if utils#is_special_buffer()
    return ''
  endif
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunc

function! LightLineLineinfo() 
  if utils#is_special_buffer()
    return ""
  endif
  return ' ' . line('.').':'. col('.')
endfunc

function! LightLinePercent() 
  if utils#is_special_buffer()
    return ''
  endif
  return line('.') * 100 / line('$') . '%'
endfunc

function! LightLineHomeMode()
  if &buftype == 'terminal'
    return toupper(&buftype)
  elseif &buftype == 'quickfix'
    return toupper(&buftype)
  elseif utils#is_special_buffer()
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
  if utils#is_special_buffer()
    return ""
  endif
  return get(g:, 'coc_git_status', '')
endfunction

function! LightLineGitStatus()
  if utils#is_special_buffer()
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
  if utils#is_special_buffer()
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
  if utils#is_special_buffer() || winwidth(0) <= 70
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


nmap <silent> <expr> <Leader>1 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(1)"
nmap <silent> <expr> <Leader>2 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(2)"
nmap <silent> <expr> <Leader>3 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(3)"
nmap <silent> <expr> <Leader>4 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(4)"
nmap <silent> <expr> <Leader>5 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(5)"
nmap <silent> <expr> <Leader>6 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(6)"
nmap <silent> <expr> <Leader>7 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(7)"
nmap <silent> <expr> <Leader>8 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(8)"
nmap <silent> <expr> <Leader>9 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(9)"
nmap <silent> <expr> <Leader>0 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(10)"

" startify
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

let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ ]


if exists('*dein#get')
  let s:total_plugins = len(dein#get())
elseif exists('*plug#begin')
  let s:total_plugins = len(keys(g:plugs))
else
  let s:total_plugins = ''
endif

let g:startify_custom_footer =
      \ ['', "   neovim loaded " . s:total_plugins . " plugins.", '']

function! StartifyEntryFormat()
  return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction

autocmd User Startified setlocal buflisted
