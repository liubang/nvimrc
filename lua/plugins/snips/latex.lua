--=====================================================================
--
-- latex.lua -
--
-- Created by liubang on 2023/04/16 00:15
-- Last Modified: 2023/04/16 00:15
--
--=====================================================================
local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin

local get_visual = function(_, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1, ""))
  end
end

ls.add_snippets("tex", {
  s(
    { trig = "dcc", snippetType = "autosnippet" },
    fmta(
      [=[
        \documentclass[<>]{<>}
        ]=],
      {
        i(1, "a4paper"),
        i(2, "article"),
      }
    ),
    { condition = line_begin }
  ),
  s(
    { trig = "pack", snippetType = "autosnippet" },
    fmta(
      [[
        \usepackage{<>}
        ]],
      {
        d(1, get_visual),
      }
    ),
    { condition = line_begin }
  ),
  s(
    { trig = "nc" },
    fmta([[\newcommand{<>}{<>}]], {
      i(1),
      i(2),
    }),
    { condition = line_begin }
  ),
  s(
    { trig = "new", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{<>}
            <>
        \end{<>}
      ]],
      {
        i(1),
        d(2, get_visual),
        rep(1),
      }
    ),
    { condition = line_begin }
  ),
  s(
    { trig = "itt", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{itemize}
            \item <>
        \end{itemize}
      ]],
      {
        i(0),
      }
    ),
    { condition = line_begin }
  ),
  s(
    { trig = "enn", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{enumerate}
            \item <>
        \end{enumerate}
      ]],
      {
        i(0),
      }
    )
  ),
})
