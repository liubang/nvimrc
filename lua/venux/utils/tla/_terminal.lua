-- Copyright (c) 2026 The Authors. All rights reserved.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      https://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- Authors: liubang (it.liubang@gmail.com)

--[[
Terminal backend: toggleterm.

To switch to another terminal library, replace this file.
The only contract is: return a function that accepts a command string
and executes it in a visible terminal.
--]]

local TERM_ID = 99
local instance = nil ---@type table|nil

---Send a command string to a dedicated terminal for execution.
---@param cmd_str string
return function(cmd_str)
  local Terminal = require("toggleterm.terminal").Terminal
  if not instance then
    instance = Terminal:new({
      count = TERM_ID,
      direction = "horizontal",
      close_on_exit = false,
      auto_scroll = true,
      on_open = function(t)
        if t.window and vim.api.nvim_win_is_valid(t.window) then
          vim.api.nvim_set_option_value("number", false, { win = t.window })
          vim.api.nvim_set_option_value("relativenumber", false, { win = t.window })
          vim.api.nvim_set_option_value("signcolumn", "no", { win = t.window })
        end
      end,
    })
  end
  if not instance:is_open() then
    instance:open()
  end
  instance:send(cmd_str, false)
end
