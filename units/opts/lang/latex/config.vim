"======================================================================
"
" config.vim - 
"
" Created by liubang on 2018/11/20
" Last Modified: 2018/11/20 10:36:56
"
"======================================================================

"----------------------------------------------------------------------
" init
"----------------------------------------------------------------------
set conceallevel=1
let g:vimtex_mappings_enabled = 0
let g:tex_stylish = 1
let g:tex_conceal = 'abdmg'
let g:tex_flavor = "tex"
let g:tex_isk='48-57,a-z,A-Z,192-255,:'

let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_index_split_pos = 'full'
let g:vimtex_index_mode = 2
let g:vimtex_fold_enabled = 0
let g:vimtex_toc_fold = 1
let g:vimtex_toc_hotkeys = {'enabled' : 1}
let g:vimtex_format_enabled = 1
let g:vimtex_quickfix_mode=0
let g:vimtex_imaps_leader = '\|'
let g:vimtex_complete_img_use_tail = 1
let g:vimtex_latexmk_build_dir='build'

if g:lbvim.os.mac
  function! UpdateSkim(status)
    if !a:status | return | endif

    let l:out = b:vimtex.out()
    let l:tex = expand('%:p')
    let l:cmd = [g:vimtex_view_general_viewer, '-r']
    if !empty(system('pgrep Skim'))
      call extend(l:cmd, ['-g'])
    endif
    if has('nvim')
      call jobstart(l:cmd + [line('.'), l:out, l:tex])
    elseif has('job')
      call job_start(l:cmd + [line('.'), l:out, l:tex])
    else
      call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
    endif
  endfunction
  let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
  let g:vimtex_view_general_options = '-r @line @pdf @tex'
  let g:vimtex_latexmk_callback_hooks = ['UpdateSkim']
elseif g:lbvim.os.linux
  let g:vimtex_view_method = "zathura"
endif

let g:vimtex_view_automatic = 1
if g:lbvim.nvim
  let g:vimtex_compiler_progname = 'nvr'
endif


"----------------------------------------------------------------------
" mappings
"----------------------------------------------------------------------
function! s:vimtex_key_mapping()
  call utils#map('n', '<leader>to', '<plug>(vimtex-compile)')
  call utils#map('n', '<leader>tc', '<plug>(vimtex-clean-full)')
  call utils#map('n', '<leader>tt', '<plug>(vimtex-toc-toggle)')
  call utils#map('n', '<leader>tv', '<plug>(vimtex-view)')
endfunction

"----------------------------------------------------------------------
" events
"----------------------------------------------------------------------
augroup LatexGroup
  autocmd!
  autocmd FileType plaintex,latex,tex set filetype=tex | call s:vimtex_key_mapping()
augroup END
