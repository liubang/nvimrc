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

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local ts_utils = require("nvim-treesitter.ts_utils")

local function get_class_name()
  local bufnr = vim.api.nvim_get_current_buf()
  local curr = ts_utils.get_node_at_cursor()
  local expr = curr
  while expr do
    if expr:type() == "class_specifier" or expr:type() == "struct_specifier" then
      break
    end
    expr = expr:parent()
  end
  if not expr then
    return ""
  end
  return vim.treesitter.get_node_text(expr:child(1), bufnr)
end

local snippets = {
  s("disablecopymove", {
    t({ "// disable copy and move", "" }),
    f(function()
      return get_class_name()
    end, {}, {}),
    t({ "(const " }),
    f(function()
      return get_class_name()
    end, {}, {}),
    t({ "&) = delete;", "" }),
    f(function()
      return get_class_name()
    end, {}, {}),
    t({ "(" }),
    f(function()
      return get_class_name()
    end, {}, {}),
    t({ "&&) = delete;", "" }),
    f(function()
      return get_class_name()
    end),
    t({ "& operator=(const " }),
    f(function()
      return get_class_name()
    end),
    t({ "&) = delete;", "" }),
    f(function()
      return get_class_name()
    end),
    t({ "& operator=(" }),
    f(function()
      return get_class_name()
    end),
    t({ "&&) = delete;", "" }),
  }),
  s("defaultcopymove", {
    t({ "// default copy and move", "" }),
    f(function()
      return get_class_name()
    end, {}, {}),
    t({ "(const " }),
    f(function()
      return get_class_name()
    end, {}, {}),
    t({ "&) = default;", "" }),
    f(function()
      return get_class_name()
    end, {}, {}),
    t({ "(" }),
    f(function()
      return get_class_name()
    end, {}, {}),
    t({ "&&) = default;", "" }),
    f(function()
      return get_class_name()
    end),
    t({ "& operator=(const " }),
    f(function()
      return get_class_name()
    end),
    t({ "&) = default;", "" }),
    f(function()
      return get_class_name()
    end),
    t({ "& operator=(" }),
    f(function()
      return get_class_name()
    end),
    t({ "&&) = default;", "" }),
  }),
}

ls.add_snippets("cpp", snippets)
