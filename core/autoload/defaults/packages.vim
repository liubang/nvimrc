" Maintainer: liubang <https://github.com/iliubang>
" Version: 0.1
" vim: et ts=2 sts=2 sw=2
scriptencoding utf-8

function! defaults#packages#init()
    " vim-startify {{{
    let g:startify_custom_header = g:vim#startify#header
    let g:startify_list_order = g:vim#startify#order
    let g:startify_change_to_vcs_root = 1
    " }}}

    " nerdtree {{{
    let g:NERDTreeShowHidden=1
    let g:NERDTreeAutoDeleteBuffer=1
    let g:NERDTreeDirArrowExpandable = '+'
    let g:NERDTreeDirArrowCollapsible = '-'
    let g:NERDTreeIgnore=[
          \ '\.py[cd]$', '\~$', '\.swo$', '\.swp$', '\.DS_Store$',
          \ '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$',
          \ ]
    " close vim if the only window left open is a NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    nnoremap <F4> :NERDTreeToggle<CR>
    inoremap <F4> <ESC>:NERDTreeToggle<CR>
    nnoremap <Leader>ft :NERDTreeToggle<CR>
    nnoremap <Leader>fd :NERDTreeFind<CR>
    " }}}

    " {{{ nerdcommenter
    " 注释的时候自动加个空格, 强迫症必配
    let g:NERDSpaceDelims=1
    " }}}

    " fzf {{{
    let $LANG = 'en_US'
    autocmd! FileType fzf
    autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

    nmap <Leader>? <plug>(fzf-maps-n)
    xmap <Leader>? <plug>(fzf-maps-x)
    omap <Leader>? <plug>(fzf-maps-o)
    nnoremap <Leader>ag :Ag<CR>
    nnoremap <Leader>bb :Buffers<CR>
    nnoremap <Leader>b? :Buffers<CR>
    nnoremap <Leader>w? :Windows<CR>
    nnoremap <Leader>f? :FZF ~<CR>
    nnoremap <Leader>ff :FZF<CR>
    " }}}

    " deoplete {{{
    " Use deoplete.
    let g:deoplete#enable_at_startup = 1
    " }}}

    " jedi-vim {{{ 
    let g:jedi#popup_select_first=1
    set completeopt=longest,menuone
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#popup_on_dot = 0
    " let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\)\w*'
    let g:jedi#show_call_signatures = "0"   " 补全时不弹出函数的参数列表框
    " }}}

    " supertab {{{
    let g:SuperTabDefaultCompletionType = "<c-n>"
    let g:SuperTabCrMapping = 1
    " }}}

    " clang {{{
    if g:MAC 
      let g:deoplete#sources#clang#flags = ['-I/usr/include', '-I/usr/include/c++/4.2.1', '-I/usr/local/opt/llvm/lib/clang/5.0.1/include']
    endif
    if g:LINUX
      let g:deoplete#sources#clang#flags = ['-I/usr/include', '-I/usr/include/c++/7.2.0', '-I/usr/include/clang/4.0.1/include']
    endif
    let g:deoplete#sources#clang#executable = "/usr/bin/clang"
    let g:deoplete#sources#clang#autofill_neomake = 1
    let g:neomake_c_enabled_makers = ['clang']
    let g:neomake_cpp_enabled_makers = ['clang']
    let g:deoplete#sources#clang#std={'c': 'c11', 'cpp': 'c++1z', 'objc': 'c11', 'objcpp': 'c++1z'}
    " }}}
endfunction

