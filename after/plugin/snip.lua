-- =====================================================================
--
-- luasnip.lua -
--
-- Created by liubang on 2021/09/04 21:07
-- Last Modified: 2021/09/04 21:07
--
-- =====================================================================
local ls = require"luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")

ls.config.set_config {
  history = true,
  -- Update more often, :h events for more info.
  updateevents = 'TextChanged,TextChangedI',
}

local uuid = function()
  local random = math.random
  local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
  local out
  local subs = function(ch)
    local v = (((ch == 'x') and random(0, 15)) or random(8, 11))
    return string.format('%x', v)
  end
  out = template:gsub('[xy]', subs)
  return out
end

local __1__ = function()
  return { os.date '%Y-%m-%d' }
end

local __2__ = function()
  return { os.date '%Y-%m-%d %H:%M:%S' }
end

ls.snippets = {
  all = {
    s({ trig = 'date', wordTrig = true }, { f(__1__, {}), i(0) }),
    s({ trig = 'datetime', wordTrig = true }, { f(__2__, {}), i(0) }),
    s({ trig = 'uuid', wordTrig = true }, { f(uuid, {}), i(0) }),
    s({ trig = 'todo' }, { t 'TODO(liubang): ' }),
    s({ trig = 'fixme' }, { t 'FIXME(liubang): ' }),
    s({ trig = 'note' }, { t 'NOTE(liubang): ' }),
  },
  go = {
    s({ trig = 'main' }, {
      t { 'func main() {', '\t' },
      i(1, '// put your code hare'),
      t { '', '}' },
    }),
    s({ trig = 'pmain' }, {
      t { 'package main', '', 'func main() {', '\t' },
      i(1, '// put your code hare'),
      t { '', '}' },
    }),
  },
  cpp = {
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
    s({ trig = 'ignore' }, {
      t { '// clang-format off', '' },
      i(1, { '' }),
      t { '', '// clang-format on' },
    }),
  },
  c = {
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
  },
  lua = {
    s({ trig = 'ignore' }, {
      t '-- stylua: ignore',
    }),
    s({ trig = 'fun' }, {
      t 'function ',
      i(1, 'function_name'),
      t { '()', '  ' },
      i(0),
      t { '', 'end' },
    }),
  },
}
