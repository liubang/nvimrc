let g:coc_language_servers = {
      \ 'clangd': {
      \   'command': 'clangd',
      \   'filetypes': ['c', 'cpp', 'objc', 'objcpp'],
      \   'rootPatterns': ['compile_flags.txt', 'compile_commands.json', '.vim/', '.git/', '.hg/'],
      \ },
      \ 'php': {
      \   'command': 'node',
      \   'args': ['/usr/local/lib/node_modules/intelephense/lib/intelephense.js', '--stdio'],
      \   'filetypes': ['php'],
      \ },
      \ 'bash': {
      \   'command': 'bash-language-server',
      \   'args': ['start'],
      \   'filetypes': ['sh'],
      \   'ignoredRootPaths': ['~'],
      \ },
      \ 'lua': {
      \   'command': 'lua-lsp',
      \   'filetypes': ['lua'],
      \ },
      \ 'efm': {
      \   'command': 'efm-langserver',
      \   'args': ['-c', g:lbvim.components_dir . '/core/lsp/config.yaml'],
      \   'filetypes': ['vim', 'markdown', 'eruby'],
      \ },
      \ 'dockerfile': {
      \   'command': 'docker-langserver',
      \   'args': ['--stdio'],
      \   'filetypes': ['dockerfile'],
      \ },
      \ 'purescript': {
      \   'command': 'purescript-language-server',
      \   'args': ['--stdio'],
      \   'filetypes': ['purescript'],
      \ },
      \ }

let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
let g:coc_status_error_sign = '•'
let g:coc_status_warning_sign = '•'

inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nmap <silent><leader>gd <Plug>(coc-definition)
nmap <silent><leader>gD <Plug>(coc-declaration)
nmap <silent><leader>gi <Plug>(coc-implementation)
nmap <silent><leader>gr <Plug>(coc-references)
nmap <silent><leader>ei <Plug>(coc-diagnostic-info)
nmap <silent><leader>rn <Plug>(coc-rename)

imap <C-k> <Plug>(coc-snippets-expand)

"Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

augroup lsp_group
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  "call coc#config("languageserver", g:coc_language_servers) 
  autocmd User CocNvimInit call coc#add_extension('coc-word',
                                                 \'coc-json',
                                                 \'coc-highlight',
                                                 \'coc-snippets',
                                                 \'coc-emmet',
                                                 \'coc-css',
                                                 \'coc-tailwindcss',
                                                 \'coc-html',
                                                 \'coc-vetur',
                                                 \'coc-yaml',
                                                 \'coc-python',
                                                 \'coc-gocode',
                                                 \'coc-vetur',
                                                 \'coc-tsserver',
                                                 \'coc-emoji',
                                                 \'coc-pairs')
augroup END
