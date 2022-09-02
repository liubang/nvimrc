--=====================================================================
--
-- c.lua -
--
-- Created by liubang on 2022/09/03 03:39
-- Last Modified: 2022/09/03 03:39
--
--=====================================================================
local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets('c', {
  s({ trig = 'pmain' }, {
    t { '#include <stdio.h>', '', '' },
    t { 'int main(int argc, char* argv[]) {', '\t' },
    i(1, { '// put your code hare' }),
    t { '', '\treturn 0;', '}' },
  }),
  s({ trig = 'main' }, {
    t { 'int main(int argc, char* argv[]) {', '\t' },
    i(1, { '// put your code hare' }),
    t { '', '\treturn 0;', '}' },
  }),
})
