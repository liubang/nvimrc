"======================================================================
"
" config.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 10:37:34
"
"======================================================================

if !g:lbvim.use_lsp

"----------------------------------------------------------------------
"  init tags
"----------------------------------------------------------------------
let g:gutentags_trace = 0
set tags=./.tags;,.tags
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.git', '.hg', '.project', '.tags']
let g:gutentags_ctags_tagfile = '.tags'

" 开启高级命令
" let g:gutentags_define_advanced_commands = 1

let g:gutentags_modules = []
if executable('ctags')
  let g:gutentags_modules += ['ctags']
endif

if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" 所生成的数据文件的名称
" let g:gutentags_ctags_tagfile = '.tags'

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

if has('win32') || has('win16') || has('win64') || has('win95')
	let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
endif

let g:gutentags_plus_switch = 0

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0

" disable the default keymaps 
let g:gutentags_plus_nomap = 1


"----------------------------------------------------------------------
" key mapping 
"----------------------------------------------------------------------
function! s:tags_keymapping()
  " create tags
  nnoremap <silent><buffer><leader>mc :GutentagsUpdate<cr>
  nnoremap <silent><buffer><leader>mu :GutentagsUpdate!<cr>
  " preview tag
  nnoremap <silent><buffer><leader>mt :PreviewTag<cr>
  " Preview the function signature circularly in the command line
  nnoremap <silent><buffer><leader>ms :PreviewSignature<cr>
  " Close the preview window
  nnoremap <silent><buffer><leader>mq :PreviewClose<cr>
  " Find symbol (reference) under cursor
  nnoremap <silent><buffer><leader>cs :GscopeFind s <c-r><c-w><cr>
  " Find symbol definition under cursor
  nnoremap <silent><buffer><leader>cg :GscopeFind g <c-r><c-w><cr>
  " Functions called by this function
  nnoremap <silent><buffer><leader>cd :GscopeFind d <c-r><c-w><cr>
  " Functions calling this function
  nnoremap <silent><buffer><leader>cc :GscopeFind c <c-r><c-w><cr>
  " Find text string under cursor
  nnoremap <silent><buffer><leader>ct :GscopeFind t <c-r><c-w><cr>
  " Find egrep pattern under cursor
  nnoremap <silent><buffer><leader>ce :GscopeFind e <c-r><c-w><cr>
endfunction

"----------------------------------------------------------------------
"  preview
"----------------------------------------------------------------------
if has('autocmd')
  function! s:quickfix_keymap()
    if &buftype != 'quickfix'
      return
    endif
    nnoremap <silent><buffer>p :PreviewQuickfix<cr>
    nnoremap <silent><buffer>c :PreviewClose<cr>
    nnoremap <silent><buffer>q :close<cr>
    setlocal nonumber
  endfunc

  augroup TagQuickfix
    autocmd!
    autocmd FileType qf call s:quickfix_keymap()
  augroup END
endif

"----------------------------------------------------------------------
" events
"----------------------------------------------------------------------
augroup Tags
  autocmd!
  autocmd FileType c,cpp,objc call gutentags#setup_gutentags() | call s:tags_keymapping()
augroup END

endif
