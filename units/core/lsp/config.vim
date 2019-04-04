let s:coc_language_servers = {
      \ 'clangd': {
      \   'command': 'ccls',
      \   'filetypes': ['c', 'cpp', 'objc', 'objcpp'],
      \   'rootPatterns': ['.ccls', 'compile_commands.json', '.vim/', '.git/', '.hg/'], 
      \ },
      \ 'golang': {
      \   'command': 'gopls',
      \   'filetypes': ['go'],
      \ },
      \ 'sh': {
      \   'command': 'bash-language-server',
      \   'args': ['start'],
      \   'filetypes': ['sh'],
      \   'ignoredRootPaths': ['~'],
      \ },
      \ 'efm': {
      \   'command': 'efm-langserver',
      \   'args': ['-c', g:lbvim.components_dir . '/core/lsp/config.yaml'],
      \   'filetypes': ['vim', 'markdown', 'eruby'],
      \ },
      \ 'typescript': {
      \   'command': 'typescript-language-server',
      \   'args': ['--stdio'],
      \   'filetypes': ['typescript'],
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

" Use <C-l> for trigger snippet expand.
imap <C-k> <Plug>(coc-snippets-expand)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-n>'

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
  autocmd! User CocNvimInit call coc#config("languageserver", s:coc_language_servers) | call coc#add_extension('coc-json', 'coc-snippets', 'coc-css', 'coc-html', 'coc-yaml', 'coc-phpls')
augroup END
