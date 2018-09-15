"----------------------------------------------------------------------
"  init tags
"----------------------------------------------------------------------
function! s:tags_init()
  set tags=./.tags;,.tags
  " gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
  let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project', '.tags']
  " 开启高级命令
  " let g:gutentags_define_advanced_commands = 1

  " 同时开启 ctags 和 gtags 支持：
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
  let g:gutentags_ctags_tagfile = '.tags'

  " 配置 ctags 的参数
  let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
  let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
  let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

  " 如果使用 universal ctags 需要增加下面一行
  let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

  " 禁用 gutentags 自动加载 gtags 数据库的行为
  let g:gutentags_auto_add_gtags_cscope = 0

  " create tags
  nmap <Leader>mc :GutentagsUpdate<CR>
  nmap <Leader>mu :GutentagsUpdate!<CR>

  let g:gutentags_plus_nomap = 0

  " preview tag
  nmap <Leader>mt :PreviewTag<CR>
  " Preview the function signature circularly in the command line
  nmap <Leader>ms :PreviewSignature<CR>
  " Close the preview window
  nmap <Leader>mq :PreviewClose<CR>
endfunc

"----------------------------------------------------------------------
"  preview
"----------------------------------------------------------------------
if has('autocmd')
  function! s:quickfix_keymap()
    if &buftype != 'quickfix'
      return
    endif
    nmap <silent><buffer> p :PreviewQuickfix<CR>
    nmap <silent><buffer> c :PreviewClose<CR>
    nmap <silent><buffer> q :close<CR>
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
  autocmd FileType c,cpp,objc call s:tags_init()
augroup END
