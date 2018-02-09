" Maintainer: liubang <https://github.com/iliubang>
" Version: 0.1
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8

let g:dot_customfile = $HOME.'/.vim.custom'

function! init#begin() abort
    " Download vim-plug if unavailable
    if !g:WINDOWS
        call s:check_vim_plug()
    endif
    call defaults#better#init()
    call defaults#startify#init()
    call defaults#keybindings#init()
    call s:check_custom_file()
    " Specify a directory for plugins
    " - For Neovim: ~/.local/share/nvim/plugged
    " - Avoid using standard Vim directory names like 'plugin'
    call plug#begin('~/.vim/plugged')
    if exists('*CustomPlug')
        call CustomPlug()
    endif
endfunction

function! init#end() abort
    " Initialize plugin system
    call plug#end()
    call s:check_custom_plug()
    call defaults#theme#init()
    call defaults#packages#init()
    if exists('*CustomConfig')
        call CustomConfig()
    endif
endfunction

function! s:check_custom_file()
    if filereadable(expand(g:dot_customfile))
        execute 'source ' . g:dot_customfile
    endif
endfunction

function! s:check_vim_plug()
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endfunction

function! s:check_custom_plug()
  " https://github.com/junegunn/vim-plug/wiki/extra#automatically-install-missing-plugins-on-startup
  augroup checkPlug
    autocmd!
    autocmd VimEnter *
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \|   echom 'Some plugins need to install the missing plugins first!'
      \|   PlugInstall --sync | q
      \| endif
  augroup END
endfunction
