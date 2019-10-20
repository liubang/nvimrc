" if hidden not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=1

if exists('+pumheight')
  " pum height
  set pumheight=30
endif
" do not show mode use statuline instead
set noshowmode
set completeopt=noinsert,menuone,noselect

let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

" expand vue snippet
function! s:snippet() abort
  let l:start_line = line('.')
  let l:is_position = search('\v%x0')
  if l:is_position !=# 0
    silent! s/\v\t/    /g
    silent! s/\v%x0\n//g
    silent! s/\v%x0/\r/g
    let l:end_line = line('.')
    call cursor(l:start_line, 0)
    let l:pos = searchpos('\v\$\{\d+\}', 'n', l:end_line)
    if l:pos[0] !=# 0 && l:pos[1] !=# 0
      call cursor(l:pos[0], l:pos[1])
      normal! df}
    endif
  endif
endfunction

function! s:check_back_space() abort
  let l:col = col('.') - 1
  return !l:col || getline('.')[l:col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" use <CR> to confirm completion
inoremap <silent><expr><cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent><leader>gd <Plug>(coc-definition)
nmap <silent><leader>gD <Plug>(coc-declaration)
nmap <silent><leader>gy <Plug>(coc-type-definition)
nmap <silent><leader>gi <Plug>(coc-implementation)
nmap <silent><leader>gr <Plug>(coc-references)
nmap <silent><leader>ei <Plug>(coc-diagnostic-info)
nmap <silent><leader>rn <Plug>(coc-rename)
" Remap for format selected region
vmap <silent><leader>fm <Plug>(coc-format-selected)
nmap <silent><leader>fm <Plug>(coc-format-selected)

" Using CocList
nnoremap <silent> <Space><Space> :CocList<CR>
nnoremap <silent> <space>y       :<C-u>CocList -A --normal yank<cr>
command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold   :call CocAction('fold', <f-args>)

hi NoCocUnderline cterm=None gui=None

" vim-go
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

let g:coc_global_extensions = ['coc-word',
                              \'coc-json',
                              \'coc-highlight',
                              \'coc-snippets',
                              \'coc-emmet',
                              \'coc-css',
                              \'coc-tailwindcss',
                              \'coc-html',
                              \'coc-vetur',
                              \'coc-angular',
                              \'coc-yaml',
                              \'coc-python',
                              \'coc-java',
                              \'coc-vetur',
                              \'coc-rls',
                              \'coc-tsserver',
                              \'coc-vimlsp',
                              \'coc-emoji',
                              \'coc-pairs',
                              \'coc-git',
                              \'coc-yank',
                              \'coc-post',
                              \'coc-stylelint',
                              \'coc-diagnostic',
                              \'coc-texlab',
                              \'coc-tabnine',
                              \'coc-prettier',
                              \'coc-sql',
                              \'coc-xml',
                              \'coc-lists',
                              \ ]

if g:lbvim.os.mac 
  call coc#config('languageserver', {
    \ 'ccls': {
    \   'command': 'ccls',
    \   'filetypes': ['c', 'cpp', 'objc', 'objcpp'],
    \   'rootPatterns': ['.ccls', 'compile_commands.json', '.git'],
    \   'initializationOptions': {
    \     'cache': {'directory': '/tmp/ccls'},
    \     'clang': {
    \       'resourceDir': g:lbvim.ccls.clang_resourcedir,
    \       'extraArgs': [
    \         '-isystem',
    \         g:lbvim.ccls.clang_isystem,
    \         '-I',
    \         g:lbvim.ccls.clang_include,
    \       ]
    \     }
    \   }
    \ }
    \ })
elseif g:lbvim.os.linux 
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

augroup coc_au
  autocmd!
  autocmd FileType go let b:coc_pairs_disabled = ['<']
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd User CocQuickfixChange :CocList --normal quickfix
  autocmd CursorHold * silent call CocActionAsync('highlight')

  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
  " virtual text highlight
  autocmd ColorScheme * highlight! CocCodeLens guifg=#606060 ctermfg=60
  " vue
  autocmd CompleteDone *.vue call <SID>snippet()
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
