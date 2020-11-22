augroup user_events
  autocmd!
  autocmd TermOpen *
        \ setlocal signcolumn=no |
        \ setlocal nobuflisted |
        \ setlocal nospell |
        \ setlocal modifiable |
        " \ nmap <silent><buffer> <Esc> <Cmd>hide<CR>|
        \ nmap <silent><buffer> q :q<CR> |
        \ hi TermCursor guifg=yellow

  " restore cursor position when opening file
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &filetype != 'gitcommit' |
        \ exe "normal! g'\"" |
        \ endif

  autocmd WinEnter * if utils#maybe_special_buffer() && winnr('$') == 1 | q | endif

  " Update filetype on save if empty
  autocmd BufWritePost * nested
        \ if &l:filetype ==# '' || exists('b:ftdetect')
        \ |   unlet! b:ftdetect
        \ |   filetype detect
        \ | endif
augroup END

" This is only available in nightly neovim
" Alternatively use coc-yank or vim-highlighted-yank
if has('nvim-0.5')
  augroup TextYankHighlight
    autocmd!
    " don't execute silently in case of errors
    autocmd TextYankPost * lua require'vim.highlight'.on_yank({ timeout = 500, on_visual = false })
  augroup END
endif

