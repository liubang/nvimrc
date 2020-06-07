" mundo
set undofile
set undodir=$HOME/.vim/.cache/undo
let g:mundo_width = 50
let g:mundo_preview_height = 30
let g:mundo_right = 1
nnoremap <silent><Leader>ud :MundoToggle<CR>

" markdown-preview.nvim
let g:mkdp_preview_options = {
      \ 'mkit': {},
      \ 'katex': {},
      \ 'uml': {},
      \ 'maid': {},
      \ 'disable_sync_scroll': 0,
      \ 'sync_scroll_type': 'top',
      \ 'hide_yaml_meta': 1,
      \ 'sequence_diagrams': {
      \     'theme': 'hand'
      \   }
      \ }
let g:mkdp_auto_close = 0
nnoremap <silent><Leader>mp :MarkdownPreview<CR>

" octol/vim-cpp-enhanced-highlight
let c_no_curly_error=1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 0
let g:cpp_concepts_highlight = 0

" vim-clang-format
let g:clang_format#detect_style_file = 1
let g:clang_format#enable_fallback_style = 1
autocmd FileType c,cpp,proto nnoremap <silent><buffer><leader>cf :<c-u>ClangFormat<cr>
autocmd FileType c,cpp,proto vnoremap <silent><buffer><leader>cf :ClangFormat<cr>

" vista.vim
let g:vista#renderer#enable_icon = 1
let g:vista_default_executive = 'ctags'
let g:vista_echo_cursor = 0
let g:vista_fzf_preview = ['right:50%']
let g:vista_executive_for = {
  \ 'markdown': 'toc',
  \ 'vim': 'ctags',
  \ 'go': 'coc',
  \ 'c': 'coc',
  \ 'cpp': 'coc',
  \ 'javascript': 'coc',
  \ 'typescript': 'coc',
  \ }
nnoremap <silent><leader><F3> :Vista!!<CR>
nnoremap <silent><leader>tl :Vista!!<CR>
nnoremap <silent><leader>vf :Vista finder coc<CR>

" asyncrun.vim
let g:asyncrun_open = 25
let g:asyncrun_bell = 1
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']
nnoremap <Leader>ar :AsyncRun<Space>

" asynctasks.vim
let g:asynctasks_term_pos = 'right'
let g:asynctasks_term_reuse = 0

function! s:asynctask_run(item)
  let p1 = stridx(a:item, '<')
  if p1 > 0 
    let name = strpart(a:item, 0, p1)
    let name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')
    if name != ''
      exec "AsyncTask ". fnameescape(name)
    endif
  endif
endfunc

function! s:fzf_tasks_list() 
  let rows = asynctasks#source(&columns * 48 / 100)
  let source = []
  for row in rows 
    let source += [row[0]. '  ' . row[1] . '  : ' . row[2]]
  endfor
  call fzf#run({
    \ 'source': source,
    \ 'sink': function('s:asynctask_run'),
    \ 'options': utils#fzf_options('TaskList'),
    \ 'down': '20%',
    \ })
endfunc

command! -bang -nargs=0 TaskList call MenuHelp_TaskList()
command! -bang -nargs=0 TaskListFzf call s:fzf_tasks_list()
nnoremap <silent><Leader>ts :TaskListFzf<CR>
nnoremap <silent><C-x> :AsyncTask file-build-and-run<CR>
nnoremap <silent><C-b> :AsyncTask file-build<CR>
nnoremap <silent><C-r> :AsyncTask file-run<CR> 

" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

" vim-floaterm
let g:floaterm_wintype = 'normal'
let g:floaterm_position = 'bottom'
let g:floaterm_height = 0.35
let g:floaterm_keymap_toggle = '<Ctrl>-d'
let g:floaterm_open_command = 'split'
highlight Floaterm guibg=black
nnoremap <silent><Leader>tw :FloatermNew<CR>

" vim-quickui
noremap <silent><Leader>to :call quickui#menu#open()<CR>
nnoremap <silent><expr><Leader>bb (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') 
  . ":call quickui#tools#list_buffer('e')\<CR>"

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCreateDefaultMappings = 0
let g:NERDRemoveExtraSpaces = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
map <silent><Leader>cc <Plug>NERDCommenterToggle
map <silent><Leader>cs <Plug>NERDCommenterSexy
map <silent><Leader>cu <Plug>NERDCommenterUncomment

" vim-sneak
let g:sneak#label = 1
