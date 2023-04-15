--=====================================================================
--
-- python.lua -
--
-- Created by liubang on 2023/04/15 23:50
-- Last Modified: 2023/04/15 23:50
--
--=====================================================================
local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local line_begin = require("luasnip.extras.expand_conditions").line_begin

local get_visual = function(_, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1, ""))
  end
end

-- see latex infinite list for the idea. Allows to keep adding arguments via choice nodes.
local function py_init()
  return sn(
    nil,
    c(1, {
      t "",
      sn(1, {
        t ", ",
        i(1),
        d(2, py_init),
      }),
    })
  )
end

-- splits the string of the comma separated argument list into the arguments
-- and returns the text-/insert- or restore-nodes
local function to_init_assign(args)
  local tab = {}
  local a = args[1][1]
  if #a == 0 then
    table.insert(tab, t { "", "\tpass" })
  else
    local cnt = 1
    for e in string.gmatch(a, " ?([^,]*) ?") do
      if #e > 0 then
        table.insert(tab, t { "", "\tself." })
        -- use a restore-node to be able to keep the possibly changed attribute name
        -- (otherwise this function would always restore the default, even if the user
        -- changed the name)
        table.insert(tab, r(cnt, tostring(cnt), i(nil, e)))
        table.insert(tab, t " = ")
        table.insert(tab, t(e))
        cnt = cnt + 1
      end
    end
  end
  return sn(nil, tab)
end

ls.add_snippets("python", {
  s(
    { trig = "main", snippetType = "autosnippet" },
    fmta(
      [[
      if __name__ == "__main__":
          <>
      ]],
      {
        d(1, get_visual),
      }
    ),
    { condition = line_begin }
  ),
  s(
    { trig = "class" },
    fmta(
      [[
        class <>(<>):
            def __init__(self<>):
                <>
        ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
      }
    ),
    { condition = line_begin }
  ),
  s(
    "pyinit",
    fmt([[def __init__(self{}):{}]], {
      d(1, py_init),
      d(2, to_init_assign, { 1 }),
    })
  ),
})
