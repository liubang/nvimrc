"======================================================================
"
" config.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 10:36:05
"
"======================================================================

if !g:lbvim.nvim
  set pyxversion=3
endif

" {{{ snips 
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
      \ pumvisible() ? "\<C-n>" :
      \ neosnippet#expandable_or_jumpable() ?
      \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
" }}}

" {{{ deoplete 
inoremap <expr> <C-g> deoplete#undo_completion()
inoremap <expr> <C-l> deoplete#refresh()

let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#sources#syntax#min_keyword_length = 3
let g:neosnippet#enable_completed_snippet = 1
set completeopt-=preview
let g:deoplete#auto_complete_delay = 5  " Default is 50
let g:deoplete#auto_refresh_delay = 30  " Default is 500

" buffer improve
let g:require_same_filetype = 'False'
" auto_refresh
let g:auto_refresh_delay = 0

" Define the input_patterns mapping so that it can be configured
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

call deoplete#custom#option('refresh_always', v:false)
call deoplete#custom#option('camel_case', v:false)
call deoplete#custom#option('ignore_case', v:true)
call deoplete#custom#option('smart_case', v:false)
call deoplete#custom#option('on_insert_enter', v:true)
call deoplete#custom#option('on_text_changed_i', v:true)
call deoplete#custom#option('min_pattern_length', 1)
call deoplete#custom#option('num_processes', 10)
call deoplete#custom#option('max_list', 30)
call deoplete#custom#option('skip_chars', ['(', ')', '<', '>'])

let g:deoplete#sources = get(g:, 'deoplete#sources', {})
let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})

" Disable the candidates in Comment/String syntaxes.
call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])

" tag, disabled.
call deoplete#custom#source('tag',           'mark', '[tag]')
call deoplete#custom#source('tag',           'filetypes', ['xxxxx'])

" emoji, don't show emoji mark
call deoplete#custom#source('emoji',         'mark', '')
call deoplete#custom#source('emoji',         'rank', 400)
call deoplete#custom#source('emoji',         'filetypes', ['markdown'])

" phpcd
call deoplete#custom#source('phpcd',         'mark', '[php]')
call deoplete#custom#source('phpcd',         'rank', 400)
call deoplete#custom#source('phpcd',         'filetypes', ['php'])

" golang
call deoplete#custom#source('go',            'mark', '[golang]')
call deoplete#custom#source('go',            'rank', 400)
call deoplete#custom#source('go',            'filetypes', ['go'])

" vim
call deoplete#custom#source('vim',           'mark', '[vim]')
call deoplete#custom#source('vim',           'rank', 400)
call deoplete#custom#source('vim',           'filetypes', ['vim'])

" python
call deoplete#custom#source('jedi',          'mark', '[python]')
call deoplete#custom#source('jedi',          'rank', 400)
call deoplete#custom#source('jedi',          'filetypes', ['python'])

" clang
call deoplete#custom#source('clangx',        'mark', '[clang]')
call deoplete#custom#source('clangx',        'rank', 400)
call deoplete#custom#source('clangx',        'filetypes', ['c', 'cpp', 'h', 'hpp'])

" system 
call deoplete#custom#source('omni',          'mark', '[omni]')
call deoplete#custom#source('omni',          'rank', 370)

call deoplete#custom#source('neosnippet',    'mark', '[ns]')
call deoplete#custom#source('neosnippet',    'rank', 360)

call deoplete#custom#source('member',        'mark', '[member]')
call deoplete#custom#source('member',        'rank', 350)

call deoplete#custom#source('file',          'mark', '[file]')
call deoplete#custom#source('file',          'rank', 340)

call deoplete#custom#source('around',        'mark', '[around]')
call deoplete#custom#source('around',        'rank', 330)

call deoplete#custom#source('buffer',        'mark', '[buf]')
call deoplete#custom#source('buffer',        'rank', 320)

call deoplete#custom#source('dictionary',    'mark', '[dic]')
call deoplete#custom#source('dictionary',    'rank', 310)

call deoplete#custom#source('tmux-complete', 'mark', '[tmux]')
call deoplete#custom#source('tmux-complete', 'rank', 300)

call deoplete#custom#source('syntax',        'mark', '[syntax]')
call deoplete#custom#source('syntax',        'rank', 200)

call deoplete#custom#source('_', 'converters', [
     \ 'converter_remove_paren',
     \ 'converter_remove_overlap',
     \ 'converter_truncate_abbr',
     \ 'converter_truncate_menu',
     \ 'converter_auto_delimiter',
     \ ])
" }}}
