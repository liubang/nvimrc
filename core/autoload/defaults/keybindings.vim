" Maintainer: liubang <https://github.com/iliubang>
" Version: 0.1
" vim: et ts=2 sts=2 sw=2
scriptencoding utf-8
function! defaults#keybindings#init()
    nnoremap <Space> <NOP>
    let g:mapleader="\<Space>"
    let g:maplocalleader="\<Space>"

    " Open shell in vim {{{
    if has('nvim')
      map <Leader>' :terminal<CR>
    else
      map <Leader>' :shell<CR>
    endif
    " }}}

    " Quit normal mode {{{
    nnoremap <Leader>q  :q<CR>
    nnoremap <Leader>Q  :qa!<CR>
    " }}}

    " Bash like {{{
    inoremap <C-a> <Home>
    inoremap <C-e> <End>
    inoremap <C-d> <Delete>
    " }}}

    " Quit visual mode {{{
    vnoremap v <Esc>
    " }}}

    " buffer {{{
    nnoremap <Leader>bp :bprevious<CR>
    nnoremap <Leader>bn :bnext<CR>
    nnoremap <Leader>bf :bfirst<CR>
    nnoremap <Leader>bl :blast<CR>
    nnoremap <Leader>bd :bd<CR>
    nnoremap <Leader>bk :bw<CR>
    " }}}

    " window {{{
    nnoremap <Leader>ww <C-W>w
    nnoremap <Leader>wr <C-W>r
    nnoremap <Leader>wd <C-W>c
    nnoremap <Leader>wq <C-W>q
    nnoremap <Leader>wj <C-W>j
    nnoremap <Leader>wk <C-W>k
    nnoremap <Leader>wh <C-W>h
    nnoremap <Leader>wl <C-W>l
    nnoremap <Leader>wH <C-W>5<
    nnoremap <Leader>wL <C-W>5>
    nnoremap <Leader>wJ :resize +5<CR>
    nnoremap <Leader>wK :resize -5<CR>
    nnoremap <Leader>w= <C-W>=
    nnoremap <Leader>ws <C-W>s
    nnoremap <Leader>w- <C-W>s
    nnoremap <Leader>wv <C-W>v
    nnoremap <Leader>w\| <C-W>v
    nnoremap <Leader>w2 <C-W>v
    " }}}

    " easymotion {{{
    map <Leader><Leader> <Plug>(easymotion-prefix)
    " Consistent with spacemacs
    " <Leader>f{char} to move to {char}
    map  <Leader>jj <Plug>(easymotion-bd-f)
    nmap <Leader>jj <Plug>(easymotion-overwin-f)
    " s{char}{char} to move to {char}{char}
    nmap <Leader>jJ <Plug>(easymotion-overwin-f2)
    " Jump to line
    map <Leader>jl <Plug>(easymotion-bd-jk)
    nmap <Leader>jl <Plug>(easymotion-overwin-line)
    " Jump to word
    map  <Leader>jw <Plug>(easymotion-bd-w)
    nmap <Leader>jw <Plug>(easymotion-overwin-w)
    " }}}
endfunction

