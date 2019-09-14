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
nmap <silent><leader>gi <Plug>(coc-implementation)
nmap <silent><leader>gr <Plug>(coc-references)
nmap <silent><leader>ei <Plug>(coc-diagnostic-info)
nmap <silent><leader>rn <Plug>(coc-rename)
" Remap for format selected region
vmap <silent><leader>fm <Plug>(coc-format-selected)
nmap <silent><leader>fm <Plug>(coc-format-selected)

" Using CocList
nnoremap <silent> <Space><Space> :CocList<CR>
" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" Setup keymap to open yank list like
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

hi NoCocUnderline cterm=None gui=None

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
                              \'coc-go',
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
                              \'https://github.com/xabikos/vscode-react'
                              \ ]

function! <SID>go_package()
  let l:filename = expand("%:h") 
  let l:filenext = expand("%:t:r")
  let l:fileinfo = split(l:filename, "/")
  let l:len = len(l:fileinfo)
  let l:package = l:fileinfo[l:len - 1]
  call append(0, "// Package " . l:package . " provides...")
  call append(1, "package " . l:package)
endfunction

augroup coc_au
  autocmd!
  autocmd BufNewFile *.go exec ":call <SID>go_package()"
  " Or use formatexpr for range format
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Show signature help while editing
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " Use K for show documentation in preview window
  " autocmd CursorHold * call CocActionAsync('doHover')
  " Highlight symbol under cursor on CursorHold
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
