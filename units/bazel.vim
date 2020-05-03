"======================================================================
"
" bazel.vim - 
"
" Created by liubang on 2020/05/02
" Last Modified: 2020/05/02 01:12
"
"======================================================================
" vim: et ts=2 sts=2 sw=2

let s:workspace = ''
let g:bazel_targets = []

function! s:BazelBuild(item)
  call asyncrun#run("", {'cwd': '<root>', 'mode': 'term'}, 'bazel build ' . a:item)
endfunc

function! s:BazelRun(item)
  let bazel_bin = s:workspace . '/bazel-bin'  
  let cmd = bazel_bin . substitute(strpart(a:item, 1), ':', '/', 'g')
  call asyncrun#run("", {'cwd': '<root>', 'mode': 'term'}, cmd)
endfunc

function! s:DefineCmd()
  command! -bang -nargs=0 BazelUpdateTargets call s:Setup()
  command! -bang -nargs=0 BazelBuild call fzf#run({
    \ 'source': g:bazel_targets,
    \ 'sink': function('s:BazelBuild'),
    \ 'options': '-m ' . utils#fzf_options('Files'),
    \ 'down': '35%',
    \ })
  command! -bang -nargs=0 BazelRun call fzf#run({
    \ 'source': g:bazel_targets,
    \ 'sink': function('s:BazelRun'),
    \ 'options': '-m ' . utils#fzf_options('Files'),
    \ 'down': '35%',
    \ })
  nnoremap <silent><Leader>bz :BazelBuild<CR>
  nnoremap <silent><Leader>br :BazelRun<CR>
  nnoremap <silent><Leader>bu :BazelUpdateTargets<CR>
endfunc

function s:Setup()
  let s:workspace = asyncrun#get_root('%')
  if filereadable(s:workspace . '/WORKSPACE')
    call s:DefineCmd()
    python3 << EOF
import vim
import os

def bazel_get_targets():
  cmd = "bazel query 'kind(\"rule\", //...)'"
  try:
    stream = os.popen(cmd)
    output = stream.read()
    targets = output.split('\n')
    result = []
    for target in targets:
      if target.startswith('//'): 
        result.append(target)
    vim.vars['bazel_targets'] = result
    print('BazelParseTargets Done.')
  except vim.error:
    print("vim error: %s" % vim.error)

if __name__ == '__main__':
  vim.async_call(bazel_get_targets)
EOF
  endif
endfunc

if executable('bazel')
  autocmd VimEnter * call s:Setup()
endif
