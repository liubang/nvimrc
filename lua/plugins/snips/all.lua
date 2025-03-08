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
local util = require("lb.utils.util")
-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local F = require("luasnip.nodes.functionNode").F
local fmta = require("luasnip.extras.fmt").fmta
local author = "liubang"

local partial = function(func, ...)
  return F(function(_, _, ...)
    return func(...)
  end, {}, { user_args = { ... } })
end

local function box(opts)
  local function box_width()
    return opts.box_width or vim.opt.textwidth:get()
  end

  local function padding(cs, input_text)
    local spaces = box_width() - (2 * #cs)
    spaces = spaces - #input_text
    return spaces / 2
  end

  local comment_string = function()
    return require("luasnip.util.util").buffer_comment_chars()[1]
  end

  return {
    f(function()
      local cs = comment_string()
      return string.rep(string.sub(cs, 1, 1), box_width())
    end, { 1 }),
    t({ "", "" }),
    f(function(args)
      local cs = comment_string()
      return cs .. string.rep(" ", math.floor(padding(cs, args[1][1])))
    end, { 1 }),
    i(1, "placeholder"),
    f(function(args)
      local cs = comment_string()
      return string.rep(" ", math.ceil(padding(cs, args[1][1]))) .. cs
    end, { 1 }),
    t({ "", "" }),
    f(function()
      local cs = comment_string()
      return string.rep(string.sub(cs, 1, 1), box_width())
    end, { 1 }),
  }
end

local snippets = {
  ls.s("time", partial(vim.fn.strftime, "%H:%M:%S")),
  ls.s("date", partial(vim.fn.strftime, "%Y-%m-%d")),
  ls.s("datetime", partial(vim.fn.strftime, "%Y-%m-%d %H:%M:%S")),
  ls.s("pwd", { partial(util.shell, "pwd") }),
  ls.s({ trig = "uuid", wordTrig = true }, { ls.f(util.uuid), ls.i(0) }),
  ls.s("shrug", { ls.t("¯\\_(ツ)_/¯") }),
  ls.s("angry", { ls.t("(╯°□°）╯︵ ┻━┻") }),
  ls.s("happy", { ls.t("ヽ(´▽`)/") }),
  ls.s("sad", { ls.t("(－‸ლ)") }),
  ls.s("confused", { ls.t("(｡･ω･｡)") }),
  ls.s({ trig = "randstr(%d+)", regTrig = true }, {
    ls.f(function(_, snip)
      return util.random_string(snip.captures[1])
    end),
    ls.i(0),
  }),
  s({ trig = "box" }, box({ box_width = 24 })),
  s({ trig = "bbox" }, box({})),
}

local get_cstring = function()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local ref_position = { cursor[1], cursor[2] + 1 }
  local cstring = require("mini.comment").get_commentstring(ref_position) or ""
  local cstring_table = vim.split(cstring, "%s", { plain = true, trimempty = true })
  if #cstring_table == 0 then
    return { "", "" }
  end
  return #cstring_table == 1 and { cstring_table[1], "" } or { cstring_table[1], cstring_table[2] }
end

local todo_snippet_nodes = function(aliases, opts)
  _ = opts
  local aliases_nodes = vim.tbl_map(function(alias)
    return i(nil, alias)
  end, aliases)
  -- format them into the actual snippet
  local comment_node = fmta("<><>(" .. author .. "): <> <>", {
    f(function()
      return get_cstring()[1]
    end),
    c(1, aliases_nodes),
    i(2),
    f(function()
      return get_cstring()[2]
    end),
  })
  return comment_node
end

local todo_snippet = function(context, aliases, opts)
  opts = opts or {}
  aliases = type(aliases) == "string" and { aliases } or aliases
  context = context or {}
  if not context.trig then
    return error("context doesn't include a `trig` key which is mandatory", 2)
  end
  opts.ctype = opts.ctype or 1
  local alias_string = table.concat(aliases, "|")
  context.name = context.name or (alias_string .. " comment")
  context.dscr = context.dscr or (alias_string .. " comment with a signature-mark")
  local comment_node = todo_snippet_nodes(aliases, opts)
  return s(context, comment_node, opts)
end

local todo_snippet_specs = {
  { { trig = "todo" }, "TODO" },
  { { trig = "fix" }, { "FIX", "BUG", "ISSUE", "FIXIT" } },
  { { trig = "hack" }, "HACK" },
  { { trig = "warn" }, { "WARN", "WARNING" } },
  { { trig = "perf" }, { "PERF", "PERFORMANCE", "OPTIM", "OPTIMIZE" } },
  { { trig = "note" }, { "NOTE", "INFO" } },
  { { trig = "todob" }, "TODO", { ctype = 2 } },
  { { trig = "fixb" }, { "FIX", "BUG", "ISSUE", "FIXIT" }, { ctype = 2 } },
  { { trig = "hackb" }, "HACK", { ctype = 2 } },
  { { trig = "warnb" }, { "WARN", "WARNING" }, { ctype = 2 } },
  { { trig = "perfb" }, { "PERF", "PERFORMANCE", "OPTIM", "OPTIMIZE" }, { ctype = 2 } },
  { { trig = "noteb" }, { "NOTE", "INFO" }, { ctype = 2 } },
}

for _, v in ipairs(todo_snippet_specs) do
  table.insert(snippets, todo_snippet(v[1], v[2], v[3]))
end

ls.add_snippets("all", snippets)
