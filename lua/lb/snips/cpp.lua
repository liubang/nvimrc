--=====================================================================
--
-- cpp.lua -
--
-- Created by liubang on 2022/09/03 03:37
-- Last Modified: 2022/09/03 03:37
--
--=====================================================================
local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

ls.add_snippets('cpp', {
  s(
    'main',
    fmt(
      [[
      int main(int argc, char *argv[]) {
        <>
        return 0;
      }
      ]],
      {
        i(1, '// put your code hare'),
      },
      {
        delimiters = '<>',
      }
    )
  ),
  s(
    'pmain',
    fmt(
      [[
      #include <<iostream>>

      int main(int argc, char *argv[]) {
        <>
        return 0;
      }
      ]],
      {
        i(1, '// put your code hare'),
      },
      {
        delimiters = '<>',
      }
    )
  ),
  s('once', {
    t { '#pragma once', '' },
    i(1),
  }),
  s('ns', {
    t 'namespace ',
    i(1),
  }),
  s(
    'class',
    fmt(
      [[
      class <> {
       public:
        <>

       private:
        <>
      };
      ]],
      {
        i(1, ''),
        i(3, ''),
        i(2, ''),
      },
      {
        delimiters = '<>',
      }
    )
  ),
  s(
    'struct',
    fmt(
      [[
      struct <> {
        <>
      };
      ]],
      {
        i(1, ''),
        i(2, ''),
      },
      {
        delimiters = '<>',
      }
    )
  ),
  s({ trig = 'formatoff' }, {
    t { '// clang-format off', '' },
    i(1, { '' }),
    t { '', '// clang-format on' },
  }),
})
