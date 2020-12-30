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
  call s:check_executable('yarn', 'yarn', ['See https://classic.yarnpkg.com/en/docs/install'])
  call s:check_executable('rg', 'ripgrep', ['See https://github.com/BurntSushi/ripgrep#installation'])
  call s:check_executable('clangd', 'clangd', ['See https://clangd.llvm.org/'])
  call s:check_executable('shfmt', 'shfmt', ['Run in shell: GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt'])
  call s:check_executable('lua-format', 'lua-format', ['Run in shell: luarocks install --server=https://luarocks.org/dev luaformatter'])
  call s:check_executable('fzy', 'fzy', ['See https://github.com/jhawthorn/fzy'])
  call s:check_executable('gopls', 'gopls', [
        \ 'Run in shell: GO111MODULE=on go get -u golang.org/x/tools/gopls',
        \ 'Run in shell: GO111MODULE=on go get -u golang.org/x/tools/cmd/...',
        \ ])
endfunc
