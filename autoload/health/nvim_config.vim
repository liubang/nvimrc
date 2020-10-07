"======================================================================
"
" nvim_config.vim - 
"
" Created by liubang on 2020/10/08
" Last Modified: 2020/10/08 00:29
"
"======================================================================

function! s:check_required_rg() abort
  if !executable('rg')
    call health#report_error('Please install ripgrep')
  else
    call health#report_ok('Require rg was successful')
  endif
endfunc

function! s:check_required_yarn() abort 
  if !executable('yarn')
    call health#report_error('Please install yarn')
  else
    call health#report_ok('Require yarn was successful')
  endif
endfunc

function! s:check_required_ccls() abort 
  if !executable('ccls')
    call health#report_error('Please install ccls')
  else
    call health#report_ok('Require ccls was successful')
  endif
endfunc

function! s:check_required_shfmt() abort 
  if !executable('shfmt')
    call health#report_error('Please install shfmt')
  else
    call health#report_ok('Require shfmt was successful')
  endif
endfunc

function! health#nvim_config#check()
  call health#report_start('Checking my nvim configuration requirements')
  call s:check_required_rg()
  call s:check_required_yarn()
  call s:check_required_ccls()
  call s:check_required_shfmt()
endfunc
