"======================================================================
"
" config.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 10:37:45
"
"======================================================================

" {{{ color mode 
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if g:lbvim.tmux
  if g:lbvim.nvim
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if g:lbvim.termguicolors
    " fix bug for vim
    if !g:lbvim.nvim
      set t_8f=^[[38;2;%lu;%lu;%lum
      set t_8b=^[[48;2;%lu;%lu;%lum
    endif
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

" {{{ lightline & tabline

silent! set laststatus=2   " 总是显示状态栏
silent! set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline

let g:lightline = {
      \ 'colorscheme': 'gruvbox9',
      \ 'active': {
      \   'left': [ ['homemode'],
      \             ['gitinfo'],['filename_active'],['cocstatus']],
      \   'right':[
      \             ['lineinfo'], ['fileformat'],['filencode'],['cocerror'],['cocwarn'],['cocfix']],
      \ },
      \ 'inactive': {
      \   'left': [['homemode'], ['filename_active']],
      \   'right':[['lineinfo']],
      \ },
      \ 'tabline': {
      \   'left': [['buffers']],
      \   'right': [['thinkvim']],
      \ },
      \ 'component': {
      \   'thinkvim': 'ﴔ ',
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers',
      \   'cocerror': 'LightLineCocError',
      \   'cocwarn' : 'LightLineCocWarn',
      \ },
      \ 'component_function': {
      \   'homemode': 'LightlineMode',
      \   'gitinfo': 'LightLineGit',
      \   'cocstatus': 'CocStatusBar',
      \   'cocfix': 'LightlineCocFixes',
      \   'filencode': 'FileEncoding',
      \   'readonly': 'LightLineReadonly',
      \   'filename_active'  : 'LightlineFilenameActive',
      \   'lineinfo': 'LightlineLineinfo',
      \   'filename': 'LightLineFname',
      \   'filetype': 'LightLineFiletype',
      \   'fileformat': 'LightLineFileformat',
      \ },
      \ 'component_type': {'buffers': 'tabsel'},
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2"},
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3"}
      \ }

function! s:lightline_is_lean() abort
  return &filetype =~? '\v^defx|mundo(diff)?$'
endfunction

function! s:lightline_is_plain() abort
  return &buftype ==? 'terminal' || &filetype =~? '\v^help|denite|defx|tagbar|vista|vista_kind$'
endfunction


function! LightlineLineinfo() abort
  return &filetype ==? 'help'             ? ''  :
  \      &filetype ==? 'defx'             ? ' ' :
  \      &filetype ==? 'denite'           ? ' ' :
  \      &filetype ==? 'tagbar'           ? ' ' :
  \      &filetype ==? 'vista'            ? ' ' :
  \      &filetype ==? 'vista_kind'       ? ' ' :
  \      &filetype =~? '\v^mundo(diff)?$' ? ' ' :
  \      s:lightline_is_lean() || s:lightline_is_plain() ? ' '  :
  \      printf('%d:%d ☰ %d%%', line('.'), col('.'), 100*line('.')/line('$'))
endfunction

function! LightlineMode() abort
    return s:lightline_is_lean() || s:lightline_is_plain() ? toupper(&filetype) : Lightlinemode()
endfunction

function! Lightlinemode()
  let nr = s:get_buffer_number()
  let nmap = [ '⓿ ',  '❶ ',  '➋ ',  '❸ ', '❹ ','❺ ',  '❻ ',  '❼ ',  '❽ ',  '❾ ','➓ ','⓫ ','⓬ ','⓭ ','⓮ ','⓯ ','⓰ ','⓱ ','⓲ ','⓳ ','⓴ ']
  if nr == 0
    return ''
  endif
  let l:number = nr
  let l:result = ''
  for i in range(1, strlen(l:number))
    let l:result = get(nmap, l:number % 10, l:number % 10) . l:result
    let l:number = l:number / 10
  endfor
  return join(['❐',l:result])
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

function! LightlineFilenameActive() abort
  if s:lightline_is_lean()
    return ''
  endif
  if &buftype ==? 'terminal'
    return has('nvim') ? b:term_title . ' (' . b:terminal_job_pid . ')' : ''
  endif
  if &filetype ==? 'denite'
    return denite#get_status_sources()
  endif
  if &filetype ==? 'tagbar'
    return get(g:lightline, 'fname', '')
  endif
  if empty(expand('%:t'))
    return '[No Name]'
  endif

  let mo = s:lightline_modified()
  return empty(mo) ? LightLineFname() : LightLineFname() . ' ' . mo
endfunction

function! s:lightline_modified() abort
  return s:lightline_is_lean() || s:lightline_is_plain() ?  ''  :
  \      &modified                                       ?  '' :
  \      &modifiable                                     ?  ''  : '-'
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! LightLineGit()
    let gitbranch=get(g:, 'coc_git_status', '')
    let gitcount=get(b:, 'coc_git_status', '')
    let gitinfo = []
    if empty(gitbranch)
      let gitbranch=""
    endif
    if empty(gitcount)
      let gitcount=""
    endif
    call add(gitinfo,gitbranch)
    call add(gitinfo,gitcount)
    return trim(join(gitinfo,''))
endfunction

function! LightLineCocStatus() abort
    let status=get(g:, 'coc_status', '')
    if empty(status)
        return ""
    endif
    return trim(status)
endfunction

function! LightLineCocError()
  let error_sign = get(g:, 'coc_status_error_sign', '😡')
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info)
    return ''
  endif
  let errmsgs = []
  if get(info, 'error', 0)
    call add(errmsgs, error_sign . info['error'])
  endif
  return join(errmsgs, ' ')
endfunction

function! CocStatusBar() abort
    let status=get(g:, 'coc_status', '')
    if empty(status)
        return ""
    endif
    let regstatus=substitute(status, "TSC", "Ⓣ ", "")
    let statusbar= split(regstatus)
    let bar=[]
    if &filetype ==? "go"
        let gobar ="Ⓖ "
        call add(statusbar,gobar)
    endif
    return join(statusbar," ")
endfunction

function! LightLineCocWarn() abort
  let warning_sign = get(g:, 'coc_status_warning_sign')
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info)
    return ''
  endif
  let warnmsgs = []
  if get(info, 'warning', 0)
    call add(warnmsgs, warning_sign . info['warning'])
  endif
 return join(warnmsgs, ' ')
endfunction

function! LightlineCocFixes() abort
  let b:coc_line_fixes = get(get(b:, 'coc_quickfixes', {}), line('.'), 0)
  return b:coc_line_fixes > 0 ? printf('%d ', b:coc_line_fixes) : ''
endfunction

" Diagnostic's feedback {{{
function! CocUpdateQuickFixes(error, actions) abort
  let coc_quickfixes = {}
  try
    for action in a:actions
      if action.kind ==? 'quickfix'
        for change in action.edit.documentChanges
          for edit in change.edits
            let start_line = edit.range.start.line + 1
            let end_line = edit.range.end.line + 1
            let coc_quickfixes[start_line] = get(coc_quickfixes, start_line, 0) + 1
            if start_line != end_line
              let coc_quickfixes[end_line] = get(coc_quickfixes, end_line, 0) + 1
            endif
          endfor
        endfor
      endif
    endfor
  catch
  endtry
  if coc_quickfixes != get(b:, 'coc_quickfixes', {})
    let b:coc_quickfixes = coc_quickfixes
    call lightline#update()
  endif
endfunction

autocmd  User CocDiagnosticChange
\   call lightline#update()
\|  call CocActionAsync('quickfixes', function('CocUpdateQuickFixes'))

function! s:coc_fix_on_cursor_moved() abort
  let current_line = line('.')
  if current_line != get(b:, 'last_line', 0)
    let b:last_line = current_line
    if has_key(get(b:, 'coc_quickfixes', {}), current_line)
      call lightline#update()
    else
      if get(b:, 'coc_line_fixes', 0) > 0
        call lightline#update()
      endif
    endif
  endif
endfunction

autocmd  CursorMoved * call s:coc_fix_on_cursor_moved()


function! LightLineFname()
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
        \ ('' != expand('%:t') ? expand('%:t') : '')
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

let g:lightline#bufferline#show_number  = 2
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#unnamed      = '[No Name]'
let g:lightline#bufferline#number_map = {
      \ 0: '⓿ ', 1: '❶ ', 2: '❷ ', 3: '❸ ', 4: '❹ ',
      \ 5: '❺ ', 6: '❻ ', 7: '❼ ', 8: '❽ ', 9: '❾ '}

nmap <silent> <expr> <Leader>1 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(1)"
nmap <silent> <expr> <Leader>2 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(2)"
nmap <silent> <expr> <Leader>3 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(3)"
nmap <silent> <expr> <Leader>4 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(4)"
nmap <silent> <expr> <Leader>5 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(5)"
nmap <silent> <expr> <Leader>6 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(6)"
nmap <silent> <expr> <Leader>7 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(7)"
nmap <silent> <expr> <Leader>8 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(8)"
nmap <silent> <expr> <Leader>9 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(9)"
nmap <silent> <expr> <Leader>0 (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(10)"
""" }}}

""" }}}

" {{{ theme
syntax on
set background=dark
let g:gruvbox_filetype_hi_groups = 1
let g:gruvbox_plugin_hi_groups = 1
let g:gruvbox_transp_bg = 1
colorscheme gruvbox9_hard
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
                            \'     Version: ' . g:lbvim.version,
                            \ ]

function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction
" }}}

"{{{ default
" 总是显示行号
set number
set showbreak=↪
set fillchars+=vert:\|  " add a bar for vertical splits
set fcs=eob:\           " hide ~
set list
set listchars=tab:»·,nbsp:+,trail:·,extends:→,precedes:←
"}}}
