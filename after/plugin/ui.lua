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

devicons.setup {
  override = {
    c = {
      icon = '',
      name = 'c',
    },
    css = {
      icon = '',
      name = 'css',
    },
    deb = {
      icon = '',
      name = 'deb',
    },
    Dockerfile = {
      icon = '',
      name = 'Dockerfile',
    },
    html = {
      icon = '',
      name = 'html',
    },
    jpeg = {
      icon = '',
      name = 'jpeg',
    },
    jpg = {
      icon = '',
      name = 'jpg',
    },
    js = {
      icon = '',
      name = 'js',
    },
    kt = {
      icon = '󱈙',
      name = 'kt',
    },
    lock = {
      icon = '',
      name = 'lock',
    },
    lua = {
      icon = '',
      name = 'lua',
    },
    mp3 = {
      icon = '',
      name = 'mp3',
    },
    mp4 = {
      icon = '',
      name = 'mp4',
    },
    out = {
      icon = '',
      name = 'out',
    },
    png = {
      icon = '',
      name = 'png',
    },
    py = {
      icon = '',
      name = 'py',
    },
    ['robots.txt'] = {
      icon = 'ﮧ',
      name = 'robots',
    },
    toml = {
      icon = '',
      name = 'toml',
    },
    ts = {
      icon = 'ﯤ',
      name = 'ts',
    },
    ttf = {
      icon = '',
      name = 'TrueTypeFont',
    },
    rb = {
      icon = '',
      name = 'rb',
    },
    rpm = {
      icon = '',
      name = 'rpm',
    },
    vue = {
      icon = '﵂',
      name = 'vue',
    },
    woff = {
      icon = '',
      name = 'WebOpenFontFormat',
    },
    woff2 = {
      icon = '',
      name = 'WebOpenFontFormat2',
    },
    xz = {
      icon = '',
      name = 'xz',
    },
    zip = {
      icon = '',
      name = 'zip',
    },
  },
}

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
-- vim.g.gruvbox_material_transparent_background = 1
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
