let $LANG = 'en_US'
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" {{{ Select buffer
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader>bb :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>
" }}}

" {{{ Search lines in all open vim buffers
function! s:line_handler(l)
  let keys = split(a:l, ':\t')
  exec 'buf' keys[0]
  exec keys[1]
  normal! ^zz
endfunction

function! s:buffer_lines()
  let res = []
  for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    call extend(res, map(getbufline(b,0,"$"), 'b . ":\t" . (v:key + 1) . ":\t" . v:val '))
  endfor
  return res
endfunction

command! FZFLines call fzf#run({
\   'source':  <sid>buffer_lines(),
\   'sink':    function('<sid>line_handler'),
\   'options': '--extended --nth=3..',
\   'down':    '60%'
\})
" }}}

" {{{ Narrow ag results within vim
function! s:ag_to_qf(line)
  let parts = split(a:line, ':')
  return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}
endfunction

function! s:ag_handler(lines)
  if len(a:lines) < 2 | return | endif

  let cmd = get({'ctrl-x': 'split',
               \ 'ctrl-v': 'vertical split',
               \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
  let list = map(a:lines[1:], 's:ag_to_qf(v:val)')

  let first = list[0]
  execute cmd escape(first.filename, ' %#\')
  execute first.lnum
  execute 'normal!' first.col.'|zz'

  if len(list) > 1
    call setqflist(list)
    copen
    wincmd p
  endif
endfunction

command! -nargs=* Ag call fzf#run({
\ 'source':  printf('ag --nogroup --column --color "%s"',
\                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
\ 'sink*':    function('<sid>ag_handler'),
\ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
\            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
\            '--color hl:68,hl+:110',
\ 'down':    '50%'
\ })

" }}}

" {{{ keybindings
nmap <Leader>? <plug>(fzf-maps-n)
xmap <Leader>? <plug>(fzf-maps-x)
omap <Leader>? <plug>(fzf-maps-o)
nnoremap <Leader>ag :Ag<CR>
nnoremap <Leader>w? :Windows<CR>
nnoremap <Leader>f? :Files ~<CR>:
nnoremap <Leader>ff :Files<CR>
nnoremap <leader>br :Buffer<cr>
nnoremap <Leader>bl :FZFLines<CR>
nnoremap <leader>bt :BTags<cr>
nnoremap <leader>ht :Helptags<cr>
nnoremap <C-p> :Files<CR>
" search current word with Ag
nnoremap <leader>wc :let @/=expand('<cword>')<cr> :Ag <C-r>/<cr><a-a>
" }}}

" add preview window, you can optionally install coderay for syntax-highlighting
" when you aren't in fullscreen, press '?' to display it
command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \                 "--hidden",
      \                 <bang>0 ? fzf#vim#with_preview('up:75%')
      \                         : fzf#vim#with_preview('right:50%:wrap:hidden', '?'),
      \                 <bang>0)

command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>,
      \                    <bang>0 ? fzf#vim#with_preview('up:75%')
      \                            : fzf#vim#with_preview('right:50%:wrap:hidden', '?'),
      \                    <bang>0)

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)
