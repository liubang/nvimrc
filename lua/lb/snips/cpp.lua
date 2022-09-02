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

ls.add_snippets('cpp', {
  s({ trig = 'pmain' }, {
    t { '#include <iostream>', '', '' },
    t { 'int main(int argc, char* argv[]) {', '\t' },
    i(1, { '// put your code hare' }),
    t { '', '\treturn 0;', '}' },
  }),
  s({ trig = 'main' }, {
    t { 'int main(int argc, char* argv[]) {', '\t' },
    i(1, { '// put your code hare' }),
    t { '', '\treturn 0;', '}' },
  }),
  s({ trig = 'formatoff' }, {
    t { '// clang-format off', '' },
    i(1, { '' }),
    t { '', '// clang-format on' },
  }),
})
