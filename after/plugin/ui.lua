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

local nui_input = require 'nui.input'
local event = require('nui.utils.autocmd').event

local function override_ui_input()
  local UIInput = nui_input:extend 'UIInput'

  function UIInput:init(opts, on_done)
    local default_value = tostring(opts.default)
    UIInput.super.init(self, {
      relative = 'cursor',
      position = {
        row = 1,
        col = 0,
      },
      size = {
        width = math.max(25, vim.api.nvim_strwidth(default_value)),
      },
      border = {
        style = 'single',
        text = {
          top = '─ [Input] ',
          top_align = 'left',
        },
      },
      win_options = {
        winhighlight = 'Normal:Normal,FloatBorder:Grey',
      },
    }, {
      prompt = '  ',
      default_value = default_value,
      on_close = function()
        on_done(nil)
      end,
      on_submit = function(value)
        on_done(value)
      end,
    })

    -- cancel operation if cursor leaves input
    self:on(event.BufLeave, function()
      on_done(nil)
    end, { once = true })

    -- cancel operation if <Esc> is pressed
    self:map('n', '<Esc>', function()
      on_done(nil)
    end, { noremap = true, nowait = true })
  end

  local input_ui

  vim.ui.input = function(opts, on_confirm)
    assert(type(on_confirm) == 'function', 'missing on_confirm function')

    if input_ui then
      -- ensure single ui.input operation
      vim.api.nvim_err_writeln 'busy: another input is pending!'
      return
    end

    input_ui = UIInput(opts, function(value)
      if input_ui then
        -- if it's still mounted, unmount it
        input_ui:unmount()
      end
      -- pass the input value
      on_confirm(value)
      -- indicate the operation is done
      input_ui = nil
    end)

    input_ui:mount()
  end
end

override_ui_input()

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

-- vim.cmd [[ highlight! link LspSagaHoverBorder Grey ]]
-- vim.cmd [[ highlight! link LspSagaDocTruncateLine Grey ]]
-- vim.cmd [[ highlight! link LspSagaDiagnosticBorder Grey ]]
-- vim.cmd [[ highlight! link LspSagaDiagnosticTruncateLine Grey ]]
-- vim.cmd [[ highlight! link LspSagaRenameBorder Grey ]]
-- vim.cmd [[ highlight! link LspSagaCodeActionBorder Grey ]]

vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

-- override some plugins color
local configuration = vim.fn['gruvbox_material#get_configuration']()
local palette = vim.fn['gruvbox_material#get_palette'](
  configuration.background,
  configuration.foreground,
  configuration.colors_override
)

vim.api.nvim_set_hl(0, 'BufferTabpageFill', {
  bold = false,
  bg = palette.bg_statusline1[1],
  fg = palette.fg1[1],
  default = false,
})
