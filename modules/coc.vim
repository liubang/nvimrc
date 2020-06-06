"======================================================================
"
" coc.vim - 
"
" Created by liubang on 2020/05/17
" Last Modified: 2020/05/17 19:14
"
"======================================================================

let g:coc_global_extensions = [
      \ 'coc-lists',
      \ 'coc-emoji',
      \ 'coc-snippets',
      \ 'coc-highlight',
      \ 'coc-prettier',
      \ 'coc-diagnostic',
      \ 'coc-pairs',
      \ 'coc-git',
      \ 'coc-json',
      \ 'coc-yaml',
      \ 'coc-vimlsp',
      \ 'coc-xml',
      \ 'coc-calc',
      \ 'coc-ci',
      \ 'coc-tsserver',
      \ 'coc-css', 
      \ 'coc-emmet',
      \ 'coc-stylelint',
      \ 'coc-java',
      \ 'coc-phpls',
      \ 'coc-python',
      \ 'coc-rls',
      \ 'coc-docker',
      \ 'coc-sh',
      \]

let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

if !empty($CLANG_RESOURCEDIR)
  let g:nvg_ccls_clang_resourcedir = $CLANG_RESOURCEDIR
else
  let g:nvg_ccls_clang_resourcedir = ''
endif

if !empty($CLANG_ISYSTEM)
  let g:nvg_ccls_clang_isystem = $CLANG_ISYSTEM
else
  let g:nvg_ccls_clang_isystem = ''
endif

if !empty($CLANG_INCLUDE)
  let g:nvg_ccls_clang_include = $CLANG_INCLUDE
else
  let g:nvg_ccls_clang_include = ''
endif

if has('macunix')
  call coc#config('languageserver', {
    \ 'ccls': {
    \   'command': 'ccls',
    \   'filetypes': ['c', 'cpp', 'objc', 'objcpp'],
    \   'rootPatterns': ['.ccls', 'compile_commands.json', '.git'],
    \   'initializationOptions': {
    \     'cache': {'directory': '/tmp/ccls'},
    \     'clang': {
    \       'resourceDir': g:nvg_ccls_clang_resourcedir,
    \       'extraArgs': [
    \         '-isystem',
    \         g:nvg_ccls_clang_isystem,
    \         '-I',
    \         g:nvg_ccls_clang_include,
    \       ]
    \     }
    \   }
    \ }
    \ })
elseif has('unix') && !has('macunix') && !has('win32unix')
  call coc#config('languageserver', {
    \ 'ccls': {
    \   'command': 'ccls',
    \   'filetypes': ['c', 'cpp', 'objc', 'objcpp'],
    \   'rootPatterns': ['.ccls', 'compile_commands.json', '.git'],
    \   'initializationOptions': {
    \     'cache': {'directory': '/tmp/ccls'},
    \     'clang': {
    \       'extraArgs': [
    \         '--gcc-toolchain=/usr'
    \       ]
    \     }
    \   }
    \ }
    \ })
endif


function! s:get_diagnostics(diags, current_buffer_only) 
  if a:current_buffer_only 
    let l:diags = filter(a:diags, {key, val -> val.file ==# expand('%:p')})
  else
    let l:diags = a:diags
  endif
  let rows = []
  for item in l:diags 
    let text = has_key(item,'file')  ? item.file : ''
    let text .= ':' . item.lnum . ':' . item.col . ' ' . item.severity . ' ' . item.message
    let rows += [text]
  endfor
  return rows
endfunc

function! s:error_handler(err) 
  let match = matchlist(a:err[1:], '\v^([^:]*):(\d+):(\d+)(.*)')[1:4] 
  if empty(match) || empty(match[0])
    return
  endif
  if empty(l:match[1]) && (bufnr(l:match[0]) == bufnr('%'))
    return
  endif
  let line = empty(match[1]) ? 1 : str2nr(match[1])
  let col = empty(match[2]) ? 1 : str2nr(match[2])
  let message = match[3]
  execute 'silent buffer' bufnr(match[0])
  call cursor(line, col)
  normal! zz
endfunc

function! s:coc_fzf_diagnostics()
  let l:current_buffer_only = index(a:000, '--current-buf') >= 0
  let l:diags = CocAction('diagnosticList')
  if !empty(l:diags) 
    call fzf#run({
      \ 'source': s:get_diagnostics(l:diags, l:current_buffer_only),
      \ 'sink': function('s:error_handler'),
      \ 'options': '-m ' . utils#fzf_options('DiagnosticList'),
      \ 'down': '30%',
      \ })
  endif
endfunc

" coc-git
highlight DiffAdd ctermfg=22 guifg=#006000 ctermbg=NONE guibg=NONE
highlight DiffChange ctermfg=58 guifg=#5F6000 ctermbg=NONE guibg=NONE
highlight DiffDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE
highlight default CocHighlightText  guibg=#725972 ctermbg=96

" command 
command! -nargs=0 CocFzfDiagnostics :call s:coc_fzf_diagnostics()
command! -nargs=? Fold   :call CocAction('fold', <f-args>)
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

augroup coc_au
  autocmd!
  autocmd FileType go let b:coc_pairs_disabled = ['<']
  autocmd FileType markdown let b:coc_pairs_disabled = ['`']
  " autocmd BufWritePre *.go   :call CocAction('runCommand', 'editor.action.organizeImport')
  autocmd BufWritePre *.java :call CocAction('runCommand', 'java.action.organizeImports')
  autocmd FileType vim let b:coc_pairs_disabled = ['"']
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd User CocQuickfixChange :CocList --normal quickfix
  autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
  " virtual text highlight
  autocmd ColorScheme * highlight! CocCodeLens guifg=#606060 ctermfg=60
  " error/warning/info/hit sign
  autocmd ColorScheme * highlight! CocErrorSign ctermfg=Red guifg=#ea6962
  autocmd ColorScheme * highlight! CocWarningSign ctermfg=Yellow guifg=#e3a84e
  autocmd ColorScheme * highlight! CocInfoSign ctermfg=Blue guifg=#7dae9b
  autocmd ColorScheme * highlight! CocHintSign ctermfg=Blue guifg=#7dae9b
  " diff sign highlight groups
  autocmd ColorScheme * highlight GitAddHi    guifg=#b8bb26 ctermfg=40
  autocmd ColorScheme * highlight GitModifyHi guifg=#83a598 ctermfg=33
  autocmd ColorScheme * highlight GitDeleteHi guifg=#f3423a ctermfg=196
  autocmd ColorScheme * highlight CocCursorRange guibg=#b16286 guifg=#ebdbb2
  " highlight text color
  autocmd ColorScheme * highlight! CocHighlightText  guibg=#054c20 ctermbg=023
  " do not underline error/info/hit lines
  autocmd ColorScheme * highlight! link CocErrorHighlight NoCocUnderline
  autocmd ColorScheme * highlight! link CocWarningHighlight NoCocUnderline
  autocmd ColorScheme * highlight! link CocInfoHighlight NoCocUnderline
  autocmd ColorScheme * highlight! link CocHintHighlight NoCocUnderline
augroup END
