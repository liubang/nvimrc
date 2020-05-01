"======================================================================
"
" startify.vim - 
"
" Created by liubang on 2020/05/02
" Last Modified: 2020/05/02 01:22
"
"======================================================================

let g:webdevicons_enable_startify = 1
let g:startify_files_number = 8
let g:startify_enable_special = 0
let g:startify_custom_header = [
                            \'      ┬  ┬┬ ┬┌┐ ┌─┐┌┐┌┌─┐ ',
                            \'      │  ││ │├┴┐├─┤││││ ┬ ',
                            \'      ┴─┘┴└─┘└─┘┴ ┴┘└┘└─┘ ',
                            \'                          ',
                            \'      Author: liubang <it.liubang@gmail.com> ',
                            \'        Site: https://iliubang.cn            ',
                            \'     Version: ' . g:nvg_version,
                            \'        Vim : ' . utils#get_vim_version(),
                            \ ]
autocmd User Startified setlocal buflisted

function! StartifyEntryFormat()
  return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction
