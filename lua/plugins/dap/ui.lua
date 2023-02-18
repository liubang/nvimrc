--=====================================================================
--
-- ui.lua -
--
-- Created by liubang on 2023/02/18 21:29
-- Last Modified: 2023/02/18 21:29
--
--=====================================================================

local M = {}
local opts = {
  expand_lines = true,
  icons = { expanded = "", collapsed = "", circular = "" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 },
        { id = "breakpoints", size = 0.25 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
      },
      size = 40,
      position = "right",
    },
    {
      elements = {
        { id = "repl", size = 0.5 },
        { id = "console", size = 0.5 },
      },
      size = 10,
      position = "bottom",
    },
  },
  floating = {
    max_height = 0.9,
    max_width = 0.5, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be 'single', 'double' or 'rounded'
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
}

function M.setup()
  require("dapui").setup(opts)
end

return M
