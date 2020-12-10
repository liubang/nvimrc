--=====================================================================
--
-- coc.lua - 
--
-- Created by liubang on 2020/12/11
-- Last Modified: 2020/12/11 00:23
--
--=====================================================================

local M = {}

M.set_config = function() 
  vim.g.coc_global_extensions = {
    'coc-lists',
    'coc-emoji',
    'coc-diagnostic',
    'coc-prettier',
    'coc-pairs',
    'coc-git',
    'coc-json',
    'coc-yaml',
    'coc-vimlsp',
    'coc-xml',
    'coc-calc',
    'coc-cmake',
    'coc-ci',
    'coc-tsserver',
    'coc-vetur',
    'coc-eslint',
    'coc-css', 
    'coc-emmet',
    'coc-stylelint',
    'coc-java',
    'coc-jedi',
    'coc-rls',
    'coc-docker',
    'coc-sh',
  }
  vim.g.coc_snippet_next = '<TAB>'
  vim.g.coc_snippet_prev = '<S-TAB>'
end

M.set_highlight = function()
  -- coc-git
  vim.cmd [[highlight DiffAdd ctermfg=22 guifg=#006000 ctermbg=NONE guibg=NONE]]
  vim.cmd [[highlight DiffChange ctermfg=58 guifg=#5F6000 ctermbg=NONE guibg=NONE]]
  vim.cmd [[highlight DiffDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE]]
  vim.cmd [[highlight default CocHighlightText  guibg=#725972 ctermbg=96]]
  -- virtual text
  vim.cmd [[highlight! CocCodeLens guifg=#606060 ctermfg=60]]
  -- error/warning/info/hit
  vim.cmd [[highlight! CocErrorSign ctermfg=Red guifg=#ea6962]]
  vim.cmd [[highlight! CocWarningSign ctermfg=Yellow guifg=#e3a84e]]
  vim.cmd [[highlight! CocInfoSign ctermfg=Blue guifg=#7dae9b]]
  vim.cmd [[highlight! CocHintSign ctermfg=Blue guifg=#7dae9b]]
  -- diff 
  vim.cmd [[highlight GitAddHi guifg=#b8bb26 ctermfg=40]]
  vim.cmd [[highlight GitModifyHi guifg=#83a598 ctermfg=33]]
  vim.cmd [[highlight GitDeleteHi guifg=#f3423a ctermfg=196]]
  vim.cmd [[highlight CocCursorRange guibg=#b16286 guifg=#ebdbb2]]
  -- highlight text color
  vim.cmd [[highlight! CocHighlightText guibg=#054c20 ctermbg=023]]
end

M.set_command = function()
  vim.cmd [[command! -nargs=0 Format :call CocAction('format')]]
  vim.cmd [[command! -nargs=0 OR     :call CocAction('runCommand', 'editor.action.organizeImport')]]
  vim.cmd [[command! -nargs=? Fold   :call CocAction('fold', <f-args>)]]
end

M.set_autocmd = function()
  vim.cmd [[augroup coc_au]]
  vim.cmd [[  autocmd!]]
  vim.cmd [[  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')]]
  vim.cmd [[  autocmd User CocQuickfixChange :CocList --normal quickfix]]
  vim.cmd [[  autocmd CursorHold * silent call CocActionAsync('highlight')]]
  vim.cmd [[  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif]]
  vim.cmd [[augroup END]]
end

M.on_attach = function() 
  M.set_config()
  M.set_command()
  M.set_autocmd()
end

return M
