"======================================================================
"
" coder.vim - 
"
" Created by liubang on 2020/01/21
" Last Modified: 2020/01/21 16:29
"
"======================================================================

" {{{ ext
let g:coc_global_extensions = [
      \'coc-word',
      \'coc-lists',
      \'coc-emoji',
      \'coc-snippets',
      \'coc-highlight',
      \'coc-prettier',
      \'coc-diagnostic',
      \'coc-pairs',
      \'coc-git',
      \'coc-ci',
      \'coc-json',
      \'coc-yaml',
      \'coc-vimlsp',
      \'coc-sql',
      \'coc-xml',
      \'coc-calc',
      \'coc-css', 
      \'coc-html', 
      \'coc-emmet',
      \'coc-tailwindcss', 
      \'coc-vetur', 
      \'coc-stylelint',
      \'coc-java',
      \'coc-phpls',
      \'coc-pyright',
      \'coc-rls',
      \'coc-docker',
      \'coc-sh',
      \'coc-cmake',
      \]
" }}}

" {{{ c/c++
let c_no_curly_error=1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 0
let g:cpp_concepts_highlight = 0
let g:clang_format#detect_style_file = 1
let g:clang_format#enable_fallback_style = 1
autocmd FileType c,cpp,proto nnoremap <silent><buffer><leader>cf :<c-u>ClangFormat<cr>
autocmd FileType c,cpp,proto vnoremap <silent><buffer><leader>cf :ClangFormat<cr>

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
" }}}

" {{{ vim-go
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
"disable use K to run godoc
let g:go_doc_keywordprg_enabled = 0
let g:go_def_mapping_enabled = 0
" }}}

" {{{ markdown
let g:mkdp_preview_options = {
      \ 'mkit': {},
      \ 'katex': {},
      \ 'uml': {},
      \ 'maid': {},
      \ 'disable_sync_scroll': 0,
      \ 'sync_scroll_type': 'top',
      \ 'hide_yaml_meta': 1,
      \ 'sequence_diagrams': {
      \     'theme': 'hand'
      \   }
      \ }
let g:mkdp_auto_close = 0
nnoremap <silent><Leader>mp :MarkdownPreview<CR>
" }}}

" {{{ coc
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
function! s:check_back_space() abort
  let l:col = col('.') - 1
  return !l:col || getline('.')[l:col - 1]  =~# '\s'
endfunc
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" goto definition
nmap <silent><leader>gd <Plug>(coc-definition)
" goto declaration
nmap <silent><leader>gD <Plug>(coc-declaration)
" goto type definition
nmap <silent><leader>gy <Plug>(coc-type-definition)
" goto implementation
nmap <silent><leader>gi <Plug>(coc-implementation)
" goto references
nmap <silent><leader>gr <Plug>(coc-references)
" error info
nmap <silent><leader>ei <Plug>(coc-diagnostic-info)
" rename
nmap <silent><leader>rn <Plug>(coc-rename)
nmap <silent><space>y :<C-u>CocList -A --normal yank<cr>
nmap <silent>w <Plug>(coc-ci-w)
nmap <silent>b <Plug>(coc-ci-b)
command! -nargs=? Fold   :call CocAction('fold', <f-args>)
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=1 Modeline :call comment#et(<q-args>)
command! -nargs=0 CopyRight :call comment#copyright('liubang')
command! -nargs=0 UpdateLastModified :call comment#update()

" {{{ coc fzf
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

command! -nargs=0 CocFzfDiagnostics :call s:coc_fzf_diagnostics()
nnoremap <silent><leader>el :CocFzfDiagnostics<CR>
" }}}

" {{{ auto cmd
augroup coc_au
  autocmd!
  autocmd FileType go let b:coc_pairs_disabled = ['<']
  autocmd FileType markdown let b:coc_pairs_disabled = ['`']
  autocmd BufWritePre *.go   :call CocAction('runCommand', 'editor.action.organizeImport')
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
" }}}

" }}}
