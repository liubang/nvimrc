-- =====================================================================
--
-- theme.lua -
--
-- Created by liubang on 2020/12/12 21:20
-- Last Modified: 2020/12/12 21:20
--
-- =====================================================================

vim.o.background = 'dark'

if vim.g.color_scheme == 'gruvbox-material' then
  vim.g.gruvbox_filetype_hi_groups = 1
  vim.g.gruvbox_plugin_hi_groups = 1
  vim.g.gruvbox_transp_bg = 1
  vim.g.gruvbox_material_enable_italic = 0
  vim.g.gruvbox_material_disable_italic_comment = 0
  vim.g.gruvbox_material_background = 'soft'
  vim.g.gruvbox_material_better_performance = 1
  -- vim.g.gruvbox_material_transparent_background = 1
  vim.cmd 'colorscheme gruvbox-material'
else
  require('kanagawa').setup {
    undercurl = true, -- enable undercurls
    commentStyle = 'italic',
    functionStyle = 'NONE',
    keywordStyle = 'NONE',
    statementStyle = 'bold',
    typeStyle = 'NONE',
    variablebuiltinStyle = 'bold',
    specialReturn = true, -- special highlight for the return keyword
    specialException = true, -- special highlight for exception handling keywords
    transparent = false, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    globalStatus = true, -- adjust window separators highlight for laststatus=3
    colors = {},
    overrides = {},
  }
  vim.cmd 'colorscheme kanagawa'
end

vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
