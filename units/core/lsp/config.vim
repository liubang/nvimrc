let s:coc_language_servers = {
      \ 'clangd': {
      \   'command': 'clangd',
      \   'filetypes': ['c', 'cpp', 'objc', 'objcpp'],
      \   'rootPatterns': ['compile_flags.txt', 'compile_commands.json', '.vim/', '.git/', '.hg/'], 
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
      \ 'python': {
      \   'command': 'pyls',
      \   'filetypes': ['python'],
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
      \ 'vue': {
      \   'command': 'vls',
      \   'filetypes': ['vue'],
      \ }
      \ }

augroup lsp_group
  autocmd!
  autocmd! User CocNvimInit :call coc#config("languageserver", s:coc_language_servers)
augroup END
