--=====================================================================
--
-- java.lua -
--
-- Created by liubang on 2023/02/18 14:50
-- Last Modified: 2023/02/18 14:50
--
--=====================================================================
local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("java", {
  s(
    "psvm",
    fmt(
      [[
      public static void main(String[] args) {
        <>
      }
      ]],
      {
        i(1, "// put your code here"),
      },
      { delimiters = "<>" }
    )
  ),
})
