let g:coc_language_servers = {
      \ 'clangd': {
      \   'command': 'ccls',
      \   'filetypes': ['c', 'cpp', 'objc', 'objcpp'],
      \   'rootPatterns': ['.ccls', 'compile_commands.json', '.vim/', '.git/', '.hg/'], 
      \ },
      \ 'golang': {
      \   'command': 'gopls',
      \   'args': [],
      \   'rootPatterns': ['go.mod', '.vim/', '.git/', '.hg/'],
      \   'filetypes': ['go'],
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

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? coc#rpc#request('doKeymap', ['snippets-expand-jump','']) :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

augroup lsp_group
  autocmd!
  autocmd! User CocNvimInit call coc#config("languageserver", g:coc_language_servers) 
        \| call coc#add_extension('coc-json', 
                                 \'coc-snippets', 
                                 \'coc-css', 
                                 \'coc-html', 
                                 \'coc-yaml', 
                                 \'coc-python', 
                                 \'coc-vetur',
                                 \'coc-tsserver')
augroup END
