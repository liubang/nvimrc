function! win#floating() abort
  let h = &lines - 3
  let w = float2nr(&columns - (&columns * 2) / 10)
  let col = float2nr((&columns - w) / 2)
  let col_offset = &columns / 6
  let opts = {
    \ 'relative': 'editor',
    \ 'row': h * 0.3,
    \ 'col': col + col_offset, 
    \ 'width': w * 2 / 3,
    \ 'height': h / 2
    \ }

  let buf = nvim_create_buf(v:true, v:false)
  let win = nvim_open_win(buf, v:true, opts)
  call setwinvar(win, '&winhl', 'Normal:Pmenu')
  setlocal 
    \ buftype=nofile
    \ nobuflisted
    \ bufhidden=hide
    \ nonumber
    \ norelativenumber 
    \ signcolumn=no
endfunction
