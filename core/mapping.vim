if dein#tap('defx.nvim')
  nnoremap <silent><Leader>ft :Defx <CR>
endif

if dein#tap('lightline.vim')
  nmap <silent> <expr> <Leader>1 (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(1)"
  nmap <silent> <expr> <Leader>2 (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(2)"
  nmap <silent> <expr> <Leader>3 (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(3)"
  nmap <silent> <expr> <Leader>4 (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(4)"
  nmap <silent> <expr> <Leader>5 (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(5)"
  nmap <silent> <expr> <Leader>6 (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(6)"
  nmap <silent> <expr> <Leader>7 (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(7)"
  nmap <silent> <expr> <Leader>8 (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(8)"
  nmap <silent> <expr> <Leader>9 (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(9)"
  nmap <silent> <expr> <Leader>0 (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(10)"
endif

if dein#tap('markdown-preview.nvim')
  nnoremap <silent><Leader>mp :MarkdownPreview<CR>
endif

if dein#tap('vim-clang-format')
  autocmd FileType c,cpp,proto nnoremap <silent><buffer><leader>cf :<c-u>ClangFormat<cr>
  autocmd FileType c,cpp,proto vnoremap <silent><buffer><leader>cf :ClangFormat<cr>
endif

if dein#tap('coc.nvim')
  function! s:check_back_space() abort
    let l:col = col('.') - 1
    return !l:col || getline('.')[l:col - 1]  =~# '\s'
  endfunc
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  nnoremap <silent><leader>el :CocFzfDiagnostics<CR>
  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
  " goto definition
  nmap <silent><leader>gd <Plug>(coc-definition)
  " goto declaration
  nmap <silent><leader>gD <Plug>(coc-declaration)
  " goto type definition
  nmap <silent><leader>gy <Plug>(coc-type-definition)
  " goto implementation
  nmap <silent><leader>gi <Plug>(coc-implementation)
  " goto references
  nmap <silent><leader>gr <Plug>(coc-references)
  " error info
  nmap <silent><leader>ei <Plug>(coc-diagnostic-info)
  " rename
  nmap <silent><leader>rn <Plug>(coc-rename)
  nmap <silent><space>y :<C-u>CocList -A --normal yank<cr>
  nmap <silent>w <Plug>(coc-ci-w)
  nmap <silent>b <Plug>(coc-ci-b)
endif

if dein#tap('fzf.vim')
  function! s:files()
    let cmd= 'rg --files --hidden --follow --glob "!.git/*"'
    let l:files = split(system(cmd), '\n')
    return s:prepend_icon(l:files)
  endfunc

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor
    return l:result
  endfunc

  function! s:edit_file(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunc

  " Files + devicons
  function! s:fzf()
    call fzf#run({
          \ 'source': <sid>files(),
          \ 'sink': function('s:edit_file'),
          \ 'options': '-m ' . utils#fzf_options('Files'),
          \ 'down': '30%'})
  endfunc

  function! s:rg(query, bang)
    let preview_opts = a:bang ? fzf#vim#with_preview('up:60%') 
          \ : fzf#vim#with_preview('right:50%')
    let root_dir = asyncrun#get_root('%')
    call extend(preview_opts.options, ['--prompt', root_dir.'> '])
    call fzf#vim#grep(
      \ 'rg --column --line-number --no-heading --smart-case '.shellescape(a:query), 1,
      \ preview_opts,
      \ a:bang,
      \ )
  endfunc

  command! -bang -nargs=* MyRg call s:rg(<q-args>, <bang>0)
  nmap <silent><Leader>? <plug>(fzf-maps-n)
  xmap <silent><Leader>? <plug>(fzf-maps-x)
  omap <silent><Leader>? <plug>(fzf-maps-o)
  nnoremap <silent> <expr> <Leader>ag (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '') . ":MyRg\<cr>"
  nnoremap <silent> <expr> <Leader>w? (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '') . ":Windows\<cr>"
  nnoremap <silent> <expr> <Leader>f? (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '') . ":Files ~\<cr>"
  nnoremap <silent> <expr> <Leader>ht (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '') . ":Helptags\<cr>"
  nnoremap <silent> <expr> <C-p>      (expand('%') =~ 'defx' ? "\<c-w>\<c-w>" : '') . ":call <sid>fzf()\<cr>"
endif

if dein#tap('vista.vim')
  nnoremap <silent><leader><F3> :Vista!!<CR>
  nnoremap <silent><leader>tl :Vista!!<CR>
  nnoremap <silent><leader>vf :Vista finder coc<CR>
  autocmd WinEnter * if &filetype== 'vista' && winnr('$') == 1 | q | endif
endif

if dein#tap('vim-easymotion')
  map <Leader>ll <Plug>(easymotion-lineforward)
  map <Leader>jj <Plug>(easymotion-j)
  map <Leader>kk <Plug>(easymotion-k)
  map <Leader>hh <Plug>(easymotion-linebackward)
  map  <Leader>ww <Plug>(easymotion-bd-w)
  nmap <Leader>ww <Plug>(easymotion-overwin-w)
endif

if dein#tap('asyncrun.vim')
  nnoremap <Leader>ar :AsyncRun<Space>
  " for git
  command! -bang -nargs=1 GitCommit
        \ :AsyncRun -cwd=<root> -raw git status && git add . && git commit -m <q-args> && git push origin
  nnoremap <Leader>gc :GitCommit<Space>
  autocmd WinEnter * if &buftype == 'quickfix' && winnr('$') == 1 | q | endif
endif

if dein#tap('vim-expand-region')
  vmap v <Plug>(expand_region_expand)
  vmap V <Plug>(expand_region_shrink)
endif

if dein#tap('vim-floaterm')
  nnoremap <silent><Leader>tw :FloatermNew<CR>
endif

if dein#tap('vim-quickui')
  noremap <silent><Leader>to :call quickui#menu#open()<CR>
  nnoremap <silent><expr><Leader>bb (expand('%') =~ 'Defx_tree' ? "\<c-w>\<c-w>" : '') 
    . ":call quickui#tools#list_buffer('e')\<CR>"
endif

if dein#tap('vim-easy-align')
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
endif

if dein#tap('nerdcommenter')
  map <silent><Leader>cc <Plug>NERDCommenterToggle
  map <silent><Leader>cs <Plug>NERDCommenterSexy
  map <silent><Leader>cu <Plug>NERDCommenterUncomment
endif

if dein#tap('asynctasks.vim')
  nnoremap <silent><Leader>ts :TaskListFzf<CR>
  nnoremap <silent><C-x> :AsyncTask file-build-and-run<CR>
  nnoremap <silent><C-b> :AsyncTask file-build<CR>
  nnoremap <silent><C-r> :AsyncTask file-run<CR> 
endif
