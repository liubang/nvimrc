let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#sources#syntax#min_keyword_length = 3

" Define the input_patterns mapping so that it can be configured
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

try
  call deoplete#custom#option('smart_case', v:true)
  call deoplete#custom#option('ignore_sources', {'_': ['around']})
  call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])
  call deoplete#custom#source('ultisnips', 'rank', 1000)
  call deoplete#custom#var('omni', 'input_patterns', {
        \ 'foam' : g:foam#complete#re_refresh_deoplete,
        \ 'tex' : g:vimtex#re#deoplete,
        \})
catch
endtry

if !g:lbvim_isnvim
  if has('python')
    set pyxversion=2
  elseif has('python3')
    set pyxversion=3
  endif
endif

let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabCrMapping = 1
let g:UltiSnipsSnippetDirectories=['UltiSnips']
let g:UltiSnipsSnippetsDir = g:lbvim_plug_home . 'vim-snippets/UltiSnips'
if has('python')
  let g:UltiSnipsUsePythonVersion = 2
elseif has('python3')
  let g:UltiSnipsUsePythonVersion = 3
endif
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsListSnippets = '<C-Tab>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
