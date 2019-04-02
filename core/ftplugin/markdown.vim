" for markdown
let g:table_mode_corner='|'
setlocal expandtab

nnoremap <silent><buffer><Leader>mp :MarkdownPreview<cr>
" https://github.com/rstacruz/cheatsheets/blob/master/vim-easyalign.md#easyalign--markdown-tables
vnoremap <silent><buffer><Leader>ta :EasyAlign *\|<cr>
