--=====================================================================
--
-- rust.lua -
--
-- Created by liubang on 2022/11/12 23:13
-- Last Modified: 2022/11/12 23:13
--
--=====================================================================

local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

ls.add_snippets('rust', {
  s(
    'main',
    fmt(
      [[
      fn main() {
          <>
      }
      ]],
      {
        i(1, 'println!("hello world")'),
      },
      {
        delimiters = '<>',
      }
    )
  ),
})
