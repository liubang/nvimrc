" LaTeX {{{

" Configure vimtex
let g:tex_stylish = 1
let g:tex_conceal = ''
let g:tex_flavor = "tex"
let g:tex_isk='48-57,a-z,A-Z,192-255,:'

let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_index_split_pos = 'full'
let g:vimtex_index_mode = 2
let g:vimtex_fold_enabled = 0
let g:vimtex_toc_fold = 1
let g:vimtex_toc_hotkeys = {'enabled' : 1}
let g:vimtex_format_enabled = 1
" https://github.com/zegervdv/homebrew-zathura
" brew install xdotool
" let g:vimtex_view_method = 'zathura'
let g:vimtex_imaps_leader = '\|'
let g:vimtex_complete_img_use_tail = 1
" let g:vimtex_view_automatic = 0
" let g:vimtex_view_forward_search_on_start = 0

if has('nvim')
  let g:vimtex_compiler_progname = 'nvr'
endif
" }}}

" Configure deoplete to work with LaTeX and the vimtex plugin
let g:deoplete#omni#input_patterns.tex = '\\(?:'
      \ .  '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
      \ . '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
      \ . '|hyperref\s*\[[^]]*'
      \ . '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
      \ . '|(?:include(?:only)?|input)\s*\{[^}]*'
      \ . '|\w*(gls|Gls|GLS)(pl)?\w*(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
      \ . '|includepdf(\s*\[[^]]*\])?\s*\{[^}]*'
      \ . '|includestandalone(\s*\[[^]]*\])?\s*\{[^}]*'
      \ . '|usepackage(\s*\[[^]]*\])?\s*\{[^}]*'
      \ . '|documentclass(\s*\[[^]]*\])?\s*\{[^}]*'
      \ . '|\w*'
      \ .')'
