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
local function get_class_name()
  local bufnr = vim.api.nvim_get_current_buf()
  local curr = vim.treesitter.get_node()
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

local function copy_move_snippet(trig, action, comment_label)
  return s(trig, {
    t({ "// " .. comment_label .. " copy and move", "" }),
    f(function()
      local cn = get_class_name()
      if cn == "" then
        return ""
      end
      return {
        cn .. "(const " .. cn .. "&) = " .. action .. ";",
        cn .. "(" .. cn .. "&&) = " .. action .. ";",
        cn .. "& operator=(const " .. cn .. "&) = " .. action .. ";",
        cn .. "& operator=(" .. cn .. "&&) = " .. action .. ";",
      }
    end),
  })
end

local is_header = function()
  return vim.fn.expand("%:e"):match("^h") ~= nil
end

local has_pragma_once = function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  for _, line in ipairs(lines) do
    if line:match("^#pragma once") then
      return true
    end
  end
  return false
end

local snippets = {
  s("cfoff", {
    t({ "// clang-format off" }),
  }),
  s("cfon", {
    t({ "// clang-format on" }),
  }),
  s("noline", {
    t({ "// NOLINTNEXTLINE" }),
  }),
  s("nolint", {
    t({ "// NOLINT" }),
  }),
  s("nodisc", {
    t({ "[[nodiscard]]" }),
  }),
  s("munused", {
    t({ "[[maybe_unused]]" }),
  }),
  s("fall", {
    t({ "[[fallthrough]]" }),
  }),
  s({ trig = "once", dscr = "#pragma once (header only)" }, {
    t({ "#pragma once", "" }),
  }, {
    condition = function()
      return is_header() and not has_pragma_once()
    end,
    show_condition = function()
      return is_header() and not has_pragma_once()
    end,
  }),
  copy_move_snippet("disablecopymove", "delete", "disable"),
  copy_move_snippet("defaultcopymove", "default", "default"),
}

return snippets
