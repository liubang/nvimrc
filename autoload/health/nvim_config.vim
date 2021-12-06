"======================================================================
"
" nvim_config.vim - 
"
" Created by liubang on 2020/10/08
" Last Modified: 2020/10/08 00:29
"
"======================================================================

function! s:check_executable(bin, name, advice) abort
  if !executable(a:bin)
    call health#report_error('Please install ' . a:name, a:advice)
  else
    call health#report_ok('Require ' . a:name . ' was successful')
  endif
endfunc

function! health#nvim_config#check()
  call health#report_start('Checking nvim configuration requirements')
  call s:check_executable('yarn', 'yarn', ['Refer to https://classic.yarnpkg.com/en/docs/install'])
  call s:check_executable('rg', 'ripgrep', ['Refer to https://github.com/BurntSushi/ripgrep#installation'])
  call s:check_executable('clangd', 'clangd', ['Refer to https://clangd.llvm.org/'])
  call s:check_executable('ccls', 'ccls', ['Refer to https://github.com/MaskRay/ccls/wiki/Build'])
  call s:check_executable('shfmt', 'shfmt', ['Run in shell: GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt'])
  call s:check_executable('buildifier', 'buildifier', ['Run in shell: GO111MODULE=on go get github.com/bazelbuild/buildtools/buildifier'])
  call s:check_executable('lua-format', 'lua-format', ['Run in shell: luarocks install --server=https://luarocks.org/dev luaformatter'])
  call s:check_executable('fzy', 'fzy', ['Refer to https://github.com/jhawthorn/fzy'])
  call s:check_executable('fzf', 'fzf', ['Refer to https://github.com/junegunn/fzf'])
  call s:check_executable('bash-language-server', 'bash-language-server', [
        \ 'Run in shell: npm i -g bash-language-server',
        \ ])
  call s:check_executable('vim-language-server', 'vim-language-server', [
        \ 'Run in shell: npm i -g vim-language-server',
        \ ])
  call s:check_executable('vscode-json-languageserver', 'vscode-json-languageserver', [
        \ 'Run in shell: npm i -g vscode-json-languageserver',
        \ ])
  call s:check_executable('yaml-language-server', 'yaml-language-server', [
        \ 'Run in shell: npm i -g yaml-language-server',
        \ ])
  call s:check_executable('prettier', 'prettier', [
        \ 'Run in shell: yarn global add prettier',
        \ ])
  call s:check_executable('cmake-language-server', 'cmake-language-server', [
        \ 'Run in shell: pip install cmake-language-server',
        \ ])
  call s:check_executable('gopls', 'gopls', [
        \ 'Run in shell: GO111MODULE=on go get -u golang.org/x/tools/gopls',
        \ 'Run in shell: GO111MODULE=on go get -u golang.org/x/tools/cmd/...',
        \ ])
  call s:check_executable('intelephense', 'intelephense', [
        \ 'Run in shell: npm install -g intelephense',
        \ ])
  call s:check_executable('texlab', 'texlab', [
        \ 'cargo install --git https://github.com/latex-lsp/texlab.git --locked',
        \ ])
  call s:check_executable('stylua', 'stylua', [
        \ 'cargo install stylua'
        \])
endfunc
