function s:comment()
  let l:ext = expand('%:e') 
  if &filetype == 'vim'
    return '"'
  elseif index(['c', 'cpp', 'h', 'hpp', 'hh', 'cc', 'cxx'], l:ext) >= 0
    return '//'
  elseif index(['m', 'mm', 'java', 'go', 'delphi', 'pascal'], l:ext) >= 0
    return '//'
  elseif index(['coffee', 'as'], l:ext) >= 0
    return '//'
  elseif index(['c', 'cpp', 'rust', 'go', 'javascript'], &filetype) >= 0
    return '//'
  elseif index(['coffee'], &filetype) >= 0
    return '//'
  elseif index(['sh', 'bash', 'python', 'php', 'perl', 'zsh'], $filetype) >= 0
    return '#'
  elseif index(['make', 'ruby', 'text'], $filetype) >= 0
    return '#'
  elseif index(['asm', 's'], l:ext) >= 0
    return ';'
  elseif index(['asm'], &filetype) >= 0
    return ';'
  elseif index(['sql', 'lua'], l:ext) >= 0
    return '--'
  elseif index(['basic'], &filetype) >= 0
    return "'"
  endif
  return '#'
endfunc

function! comment#et(indent) 
  let l:text = s:comment() . ' vim: set '
  let l:text .= 'et '
  let l:text .= 'ts=' . a:indent . ' '
  let l:text .= 'sts=' . a:indent . ' '
  let l:text .= 'sw=' . a:indent . ' '
  let l:text .= ':'
  call append(line('$') - 1, l:text)
endfunc

function! s:comment_line(char, repeat)
  let l:comment = s:comment()
  while strlen(l:comment) < a:repeat
    let l:comment .= a:char
  endwhile
  return l:comment
endfunc

function! comment#copyright(author)
  let l:c = s:comment() 
  let l:complete = s:comment_line('=', 71)
  let l:filename = expand("%:t") 
  let l:t = strftime("%Y/%m/%d")
  let l:text = []
  if &filetype == 'python'
    let l:text += ['#! /usr/bin/env python']
    let l:text += ['# -*- coding: utf-8 -*-']
  elseif &filetype == 'sh'
    let l:text += ['#! /bin/sh']
  elseif &filetype == 'bash'
    let l:text += ['#! /usr/bin/env bash']
  elseif &filetype == 'zsh'
    let l:text += ['#! /usr/bin/env zsh']
  endif
  let l:text += [l:complete]
  let l:text += [l:c]
  let l:text += [l:c . ' ' . l:filename . ' - ' ]
  let l:text += [l:c]
  let l:text += [l:c . ' Created by ' . a:author . ' on '. l:t]
  let l:text += [l:c . ' Last Modified: ' . strftime('%Y/%m/%d %H:%M') ]
  let l:text += [l:c]
  let l:text += [l:complete]
  call append(0, l:text)
endfunc

function! comment#update() 
  let _s=@/ 
  let l = line(".")
  let c = col(".")

  let n = min([10, line('$')])
  let timestamp = strftime('%Y/%m/%d %H:%M')
  let timestamp = substitute(timestamp, '%', '\%', 'g')
  let pat = substitute('Last Modified:\s*\zs.*\ze', '%', '\%', 'g')
  keepjumps silent execute '1,'.n.'s%^.*'.pat.'.*$%'.timestamp.'%e'
  let @/=_s
  call cursor(l, c)
endfunc
