let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', '#3a3a3a'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

function! s:files()
  let cmd= 'rg --files --hidden --follow --glob "!.git/*"'
  let l:files = split(system(cmd), '\n')
  return s:prepend_icon(l:files)
endfunc

function! s:prepend_icon(candidates)
  let l:result = []
  for l:candidate in a:candidates
    let l:filename = fnamemodify(l:candidate, ':p:t')
    let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
    call add(l:result, printf('%s %s', l:icon, l:candidate))
  endfor
  return l:result
endfunc

function! s:edit_file(item)
  let l:pos = stridx(a:item, ' ')
  let l:file_path = a:item[pos+1:-1]
  execute 'silent e' l:file_path
endfunc

" Files + devicons
function! s:fzf()
  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink': function('s:edit_file'),
        \ 'options': '-m ' . utils#fzf_options('Files'),
        \ 'down': '30%'})
endfunc

function! s:rg(query, bang)
  let preview_opts = a:bang ? fzf#vim#with_preview('up:60%') 
        \ : fzf#vim#with_preview('right:50%')
  let root_dir = asyncrun#get_root('%')
  call extend(preview_opts.options, ['--prompt', root_dir.'> '])
  call fzf#vim#grep(
    \ 'rg --column --line-number --no-heading --smart-case '.shellescape(a:query), 1,
    \ preview_opts,
    \ a:bang,
    \ )
endfunc

command! -bang -nargs=* MyRg call s:rg(<q-args>, <bang>0)
nmap <silent><Leader>? <plug>(fzf-maps-n)
xmap <silent><Leader>? <plug>(fzf-maps-x)
omap <silent><Leader>? <plug>(fzf-maps-o)
nnoremap <silent> <expr> <Leader>ag (utils#maybe_special_buffer() ? "\<c-w>\<c-w>" : '') . ":MyRg\<cr>"
nnoremap <silent> <expr> <Leader>w? (utils#maybe_special_buffer() ? "\<c-w>\<c-w>" : '') . ":Windows\<cr>"
nnoremap <silent> <expr> <Leader>f? (utils#maybe_special_buffer() ? "\<c-w>\<c-w>" : '') . ":Files ~\<cr>"
nnoremap <silent> <expr> <Leader>ht (utils#maybe_special_buffer() ? "\<c-w>\<c-w>" : '') . ":Helptags\<cr>"
nnoremap <silent> <expr> <Leader>fh (utils#maybe_special_buffer() ? "\<c-w>\<c-w>" : '') . ":History\<cr>"
nnoremap <silent> <expr> <Leader>ff (utils#maybe_special_buffer() ? "\<c-w>\<c-w>" : '') . ":call <sid>fzf()\<cr>"
nnoremap <silent> <expr> <C-p>      (utils#maybe_special_buffer() ? "\<c-w>\<c-w>" : '') . ":call <sid>fzf()\<cr>"
