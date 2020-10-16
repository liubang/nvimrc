"======================================================================
"
" mapping.vim - 
"
" Created by liubang on 2020/08/10
" Last Modified: 2020/08/10 00:40
"
"======================================================================
if dein#tap('defx.nvim')
  nnoremap <silent><Leader>ft :Defx <CR>
endif

if dein#tap('accelerated-jk')
  nmap j <Plug>(accelerated_jk_gj)
  nmap k <Plug>(accelerated_jk_gk)
endif

if dein#tap('nerdcommenter')
  map <silent><Leader>cc <Plug>NERDCommenterToggle
  map <silent><Leader>cs <Plug>NERDCommenterSexy
  map <silent><Leader>cu <Plug>NERDCommenterUncomment
endif

if dein#tap('vim-slash')
  noremap <plug>(slash-after) zz
endif

if dein#tap('vim-easy-align')
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
endif

if dein#tap('vim-expand-region')
  vmap v <Plug>(expand_region_expand)
  vmap V <Plug>(expand_region_shrink)
endif

if dein#tap('vim-floaterm')
  nnoremap <silent><Leader>tw :FloatermNew<CR>
endif

if dein#tap('vim-mundo')
  nnoremap <silent><Leader>ud :MundoToggle<CR>
endif

if dein#tap('asyncrun.vim')
  nnoremap <Leader>ar :AsyncRun<Space>
endif

if dein#tap('asynctasks.vim')
  nnoremap <silent><C-x> :AsyncTask file-build-and-run<CR>
  nnoremap <silent><C-b> :AsyncTask file-build<CR>
  nnoremap <silent><C-r> :AsyncTask file-run<CR> 
endif

if dein#tap('vista.vim')
  nnoremap <silent><leader>tl :Vista!!<CR>
  nnoremap <silent><leader>vf :Vista finder coc<CR>
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
  nmap <silent><leader>rf <Plug>(coc-refactor)
  nmap <silent><space>y :<C-u>CocList -A --normal yank<cr>
  nmap <silent>w <Plug>(coc-ci-w)
  nmap <silent>b <Plug>(coc-ci-b)
  nmap <silent><leader>fm <Plug>(coc-format)
endif

if dein#tap('markdown-preview.nvim')
  nnoremap <silent><Leader>mp :MarkdownPreview<CR>
endif

if dein#tap('vim-clang-format')
  autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
  autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
endif

if dein#tap('lightline-bufferline')
  nmap <silent> <expr> <Leader>1 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(1)"
  nmap <silent> <expr> <Leader>2 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(2)"
  nmap <silent> <expr> <Leader>3 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(3)"
  nmap <silent> <expr> <Leader>4 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(4)"
  nmap <silent> <expr> <Leader>5 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(5)"
  nmap <silent> <expr> <Leader>6 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(6)"
  nmap <silent> <expr> <Leader>7 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(7)"
  nmap <silent> <expr> <Leader>8 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(8)"
  nmap <silent> <expr> <Leader>9 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(9)"
  nmap <silent> <expr> <Leader>0 (utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(10)"
endif

if dein#tap('vim-clap')
  nnoremap <silent> <Leader>tc :<C-u>Clap colors<CR>
  nnoremap <silent> <Leader>bb :<C-u>Clap buffers<CR>
  nnoremap <silent> <Leader>fa :<C-u>Clap grep2<CR>
  nnoremap <silent> <Leader>fb :<C-u>Clap marks<CR>
  " ctrl-p
  nnoremap <silent> <C-p>      :<C-u>Clap filer<CR>
  nnoremap <silent> <Leader>ff :<C-u>Clap files ++finder=rg --ignore --hidden --files<cr>
  nnoremap <silent> <Leader>fg :<C-u>Clap gfiles<CR>
  nnoremap <silent> <Leader>ag :<C-u>Clap grep<cr>
  nnoremap <silent> <Leader>fw :<C-u>Clap grep ++query=<cword><cr>
  nnoremap <silent> <Leader>fh :<C-u>Clap history<CR>
  nnoremap <silent> <Leader>fW :<C-u>Clap windows<CR>
  nnoremap <silent> <Leader>fl :<C-u>Clap loclist<CR>
  nnoremap <silent> <Leader>fu :<C-u>Clap git_diff_files<CR>
  nnoremap <silent> <Leader>fv :<C-u>Clap grep ++query=@visual<CR>
  nnoremap <silent> <Leader>oc :<C-u>Clap dotfiles<CR>
  nnoremap <silent> <LocalLeader>g :<C-u>Clap gosource<CR>
endif


if dein#tap('vim-quickui')
  " tab menu
  nnoremap <silent> <Leader>tm :call quickui#menu#open()<cr>
  nnoremap <silent>K :call quickui#tools#clever_context('k', g:context_menu_k, {})<cr>
endif
