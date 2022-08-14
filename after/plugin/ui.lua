-- =====================================================================
--
-- theme.lua -
--
-- Created by liubang on 2020/12/12 21:20
-- Last Modified: 2020/12/12 21:20
--
-- =====================================================================

local notify = require 'notify'
local devicons = require 'nvim-web-devicons'
local fold = require 'pretty-fold'

devicons.setup {
  override = {
    default_icon = {
      icon = ' ',
      color = '#6d8086',
      cterm_color = '66',
      name = 'Default',
    },
  },
}

fold.setup {
  fill_char = '-',
  comment_signs = {},
  keep_indentation = false,
  sections = {
    left = {
      '+',
      function()
        return string.rep('-', vim.v.foldlevel)
      end,
      'content',
    },
    right = {
      ' ',
      'number_of_folded_lines',
      ': ',
      'percentage',
      ' ',
      function(config)
        return config.fill_char:rep(3)
      end,
    },
  },
}

notify.setup {
  -- Animation style (see below for details)
  stages = 'slide',

  -- Function called when a new window is opened, use for changing win settings/config
  on_open = nil,

  -- Function called when a window is closed
  on_close = nil,

  -- Render function for notifications. See notify-render()
  render = 'default',

  -- Default timeout for notifications
  timeout = 1500,

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

---------------- color_scheme ----------------

-- if vim.g.color_scheme == 'gruvbox-material' then
vim.o.background = 'dark'
vim.g.gruvbox_material_foreground = 'material'
vim.g.gruvbox_filetype_hi_groups = 1
vim.g.gruvbox_plugin_hi_groups = 1
vim.g.gruvbox_transp_bg = 1
vim.g.gruvbox_material_enable_italic = 0
vim.g.gruvbox_material_disable_italic_comment = 0
vim.g.gruvbox_material_background = 'soft'
vim.g.gruvbox_material_better_performance = 1
vim.cmd 'colorscheme gruvbox-material'

vim.cmd [[ highlight! link LspSagaHoverBorder Grey ]]
vim.cmd [[ highlight! link LspSagaDocTruncateLine Grey ]]
vim.cmd [[ highlight! link LspSagaDiagnosticBorder Grey ]]
vim.cmd [[ highlight! link LspSagaDiagnosticTruncateLine Grey ]]
vim.cmd [[ highlight! link LspSagaRenameBorder Grey ]]
vim.cmd [[ highlight! link LspSagaCodeActionBorder Grey ]]

vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

-- override some plugins color
-- local configuration = vim.fn['gruvbox_material#get_configuration']()
-- local palette = vim.fn['gruvbox_material#get_palette'](
--   configuration.background,
--   configuration.foreground,
--   configuration.colors_override
-- )
--
-- vim.api.nvim_set_hl(0, 'BufferCurrent', {
--   bold = true,
--   bg = palette.grey2[1],
--   fg = palette.bg0[1],
--   default = false,
-- })
--
-- vim.api.nvim_set_hl(0, 'BufferCurrentIndex', {
--   bold = true,
--   bg = palette.grey2[1],
--   fg = palette.bg0[1],
--   default = false,
-- })
--
-- vim.api.nvim_set_hl(0, 'BufferCurrentTarget', {
--   bold = false,
--   bg = palette.grey2[1],
--   fg = palette.bg0[1],
--   default = false,
-- })
--
-- vim.api.nvim_set_hl(0, 'BufferCurrentSign', {
--   bold = false,
--   bg = palette.grey2[1],
--   fg = palette.bg0[1],
--   default = false,
-- })
--
-- vim.api.nvim_set_hl(0, 'BufferCurrentIcon', {
--   bold = false,
--   bg = palette.grey2[1],
--   fg = palette.bg0[1],
--   default = false,
-- })
--
-- vim.api.nvim_set_hl(0, 'BufferTabpageFill', {
--   bold = false,
--   bg = palette.bg_statusline1[1],
--   fg = palette.fg1[1],
--   default = false,
-- })
--
-- vim.api.nvim_set_hl(0, 'BufferInactive', {
--   bold = false,
--   bg = palette.bg_statusline3[1],
--   fg = palette.fg1[1],
--   default = false,
-- })
