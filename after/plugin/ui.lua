-- =====================================================================
--
-- theme.lua -
--
-- Created by liubang on 2020/12/12 21:20
-- Last Modified: 2020/12/12 21:20
--
-- =====================================================================

local notify = require 'notify'

notify.setup {
  -- Animation style (see below for details)
  stages = 'fade_in_slide_out',

  -- Function called when a new window is opened, use for changing win settings/config
  on_open = nil,

  -- Function called when a window is closed
  on_close = nil,

  -- Render function for notifications. See notify-render()
  render = 'default',

  -- Default timeout for notifications
  timeout = 2000,

  -- Max number of columns for messages
  max_width = nil,
  -- Max number of lines for a message
  max_height = nil,

  -- For stages that change opacity this is treated as the highlight behind the window
  -- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
  background_colour = 'Normal',

  -- Minimum width for notification windows
  minimum_width = 50,

  -- Icons for the different levels
  icons = {
    ERROR = '',
    WARN = '',
    INFO = '',
    DEBUG = '',
    TRACE = '✎',
  },
}

vim.notify = notify
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
