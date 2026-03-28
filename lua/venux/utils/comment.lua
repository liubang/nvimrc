-- Copyright (c) 2024 The Authors. All rights reserved.
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

local M = {}

M.opts = {
  author = "liubang",
  email = "it.liubang@gmail.com",
}

function M.setup(opts)
  if opts.author then
    M.opts.author = opts.author
  end
  if opts.email then
    M.opts.email = opts.email
  end
end

-- stylua: ignore
local prefix_mappings = { -- {{{
  ["c"]               = "//",
  ["cpp"]             = "//",
  ["rust"]            = "//",
  ["go"]              = "//",
  ["php"]             = "//",
  ["java"]            = "//",
  ["lua"]             = "--",
  ["sql"]             = "--",
  ["vim"]             = '"',
  ["bzl"]             = "#",
  ["python"]          = "#",
  ["sh"]              = "#",
  ["zsh"]             = "#",
  ["bash"]            = "#",
  ["make"]            = "#",
  ["ruby"]            = "#",
  ["javascript"]      = "//",
  ["typescript"]      = "//",
  ["javascriptreact"] = "//",
  ["typescriptreact"] = "//",
} -- }}}

-- stylua: ignore
local header_mappings = { -- {{{
  ["php"]    = { "<?php" },
  ["sh"]     = { "#! /bin/bash" },
  ["zsh"]    = { "#! /usr/bin/env zsh" },
  ["python"] = { "#! /usr/bin/env python", "# -*- coding: utf-8 -*-" },
} -- }}}

local comment_prefix = function() -- {{{
  local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
  if prefix_mappings[filetype] ~= nil then
    return prefix_mappings[filetype]
  end
  return "#"
end -- }}}

local comment_line = function(c, r) -- {{{
  local prefix = comment_prefix()
  while string.len(prefix) < r do
    prefix = prefix .. c
  end
  return prefix
end -- }}}

function M.add_fileheader()
  local text = {}
  local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
  if header_mappings[filetype] ~= nil then
    for _, v in pairs(header_mappings[filetype]) do
      table.insert(text, v)
    end
  end
  vim.fn.append(0, text)
end

function M.copy_right() -- {{{
  local c = comment_prefix()
  local complete = comment_line("=", 71)
  local filename = vim.fn.expand("%:t")
  local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
  local t = os.date("%Y/%m/%d %H:%M")
  local text = {}
  if header_mappings[filetype] ~= nil then
    for _, v in pairs(header_mappings[filetype]) do
      table.insert(text, v)
    end
  end
  table.insert(text, complete)
  table.insert(text, c)
  table.insert(text, c .. " " .. filename .. " -")
  table.insert(text, c)
  table.insert(text, c .. " Created by " .. M.opts.author .. " on " .. t)
  table.insert(text, c .. " Last Modified: " .. t)
  table.insert(text, c)
  table.insert(text, complete)
  vim.fn.append(0, text)
end -- }}}

function M.copy_right_update() -- {{{
  local pos = vim.api.nvim_win_get_cursor(0)
  local n = math.min(10, vim.fn.line("$"))
  local timestamp = os.date("%Y/%m/%d %H:%M")
  vim.cmd("keepjumps silent execute '1," .. n .. "s%^.*Last Modified:\\s*\\zs.*\\ze.*$%" .. timestamp .. "%e'")
  vim.api.nvim_win_set_cursor(0, pos)
  -- clear last search pattern register
  vim.cmd([[let @/=""]])
end -- }}}

function M.copy_right_apache()
  local c = comment_prefix()
  local text = {}
  table.insert(text, c .. " Copyright (c) " .. os.date("%Y") .. " The Authors. All rights reserved.")
  table.insert(text, c)
  table.insert(text, c .. ' Licensed under the Apache License, Version 2.0 (the "License");')
  table.insert(text, c .. " you may not use this file except in compliance with the License.")
  table.insert(text, c .. " You may obtain a copy of the License at")
  table.insert(text, c)
  table.insert(text, c .. "      https://www.apache.org/licenses/LICENSE-2.0")
  table.insert(text, c)
  table.insert(text, c .. " Unless required by applicable law or agreed to in writing, software")
  table.insert(text, c .. ' distributed under the License is distributed on an "AS IS" BASIS,')
  table.insert(text, c .. " WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.")
  table.insert(text, c .. " See the License for the specific language governing permissions and")
  table.insert(text, c .. " limitations under the License.")
  table.insert(text, "")
  table.insert(text, string.format("%s Authors: %s (%s)", c, M.opts.author, M.opts.email))
  table.insert(text, "")
  vim.fn.append(0, text)
end

return M

-- vim: fdm=marker fdl=0
