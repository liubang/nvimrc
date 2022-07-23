--=====================================================================
--
-- dap-ui.lua -
--
-- Created by liubang on 2022/04/14 22:17
-- Last Modified: 2022/04/14 22:17
--
--=====================================================================

local dapui = require 'dapui'
local dapvt = require 'nvim-dap-virtual-text'

dapui.setup {
  icons = { expanded = '▾', collapsed = '▸' },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { 'o', '<2-LeftMouse>', '<CR>' },
    open = 'O',
    remove = 'd',
    edit = 'e',
    repl = 'r',
    toggle = 't',
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = 'scopes',
        size = 0.35, -- Can be float or integer > 1
      },
      { id = 'stacks', size = 0.35 },
      { id = 'watches', size = 0.15 },
      { id = 'breakpoints', size = 0.15 },
    },
    size = 40,
    position = 'left', -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { 'repl' },
    size = 5,
    position = 'bottom', -- Can be "left", "right", "top", "bottom"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = 'single', -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { 'q', '<Esc>' },
    },
  },
  windows = { indent = 1 },
}

dapvt.setup {
  enabled = true, -- enable this plugin (the default)
  enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
  highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_new_as_changed = true, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
  show_stop_reason = true, -- show stop reason when stopped for exceptions
  commented = false, -- prefix virtual text with comment string
  -- experimental features:
  virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
  all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
  virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
  virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
  -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}
