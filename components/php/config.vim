autocmd BufRead *.phpt setlocal ft=php
autocmd BufRead *.phtml setlocal ft=html
autocmd FileType php highlight link phpDocTags phpDefine
autocmd FileType php highlight link phpDocParam phpType

let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
let g:deoplete#ignore_sources.php = ['omni']
