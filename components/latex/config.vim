if g:lbvim_isnvim
  " Use nvr for remove communication
  let g:vimtex_latexmk_progname = 'nvr'
endif

" LaTeX {{{

" Configure vimtex
let g:vimtex_fold_enabled = 0
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_index_show_help = 0

if g:MAC
	let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
	let g:vimtex_view_general_options = '-r @line @pdf @tex'
	let g:vimtex_view_general_options_latexmk = '-r'
endif

" Conceal option
set conceallevel=2
let g:tex_conceal= 'adgms'
hi Conceal ctermbg=NONE ctermfg=172

" Use tex over plaintex
let g:tex_flavor = 'tex'

" Vimtex requires
set hidden

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

