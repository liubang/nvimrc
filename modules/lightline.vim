"======================================================================
"
" lightline.vim - 
"
" Created by liubang on 2020/05/17
" Last Modified: 2020/05/17 19:11
"
"======================================================================

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
    return &buftype =~ '\v(terminal|quickfix)' || &filetype =~ '\v(help|startify|defx|vista|undotree|SpaceVimPlugManager|git)'
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
