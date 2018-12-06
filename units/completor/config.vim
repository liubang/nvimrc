"======================================================================
"
" config.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 10:36:05
"
"======================================================================

let g:python3_host_skip_check = 1
let g:python3_host_prog = 'python3'

let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#sources#syntax#min_keyword_length = 3
let g:neosnippet#enable_completed_snippet = 1
set completeopt-=preview

" Define the input_patterns mapping so that it can be configured
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

try
  call deoplete#custom#option('smart_case', v:true)
  call deoplete#custom#option('ignore_sources', {'_': ['around']})
  call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])
  call deoplete#custom#source('UltiSnips', 'rank', 1000)
catch
  let s:path = expand('<sfile>')
  call utils#err(v:exception, s:path)
endtry

if !g:IS_NVIM
  if g:HAS_PYTHON
    set pyxversion=2
  elseif g:HAS_PYTHON3
    set pyxversion=3
  endif
endif

let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabCrMapping = 1

let g:UltiSnipsSnippetDirectories=['UltiSnips']
if g:HAS_PYTHON
  let g:UltiSnipsUsePythonVersion = 2
elseif g:HAS_PYTHON3
  let g:UltiSnipsUsePythonVersion = 3
endif
"let g:UltiSnipsExpandTrigger = '<C-k>'
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsListSnippets = '<C-Tab>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
