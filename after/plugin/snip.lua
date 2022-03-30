-- =====================================================================
--
-- luasnip.lua -
--
-- Created by liubang on 2021/09/04 21:07
-- Last Modified: 2021/09/04 21:07
--
-- =====================================================================
local ls = require 'luasnip'
-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmta = require('luasnip.extras.fmt').fmta
local calculate_comment_string = require('Comment.ft').calculate
local region = require('Comment.utils').get_region

ls.config.setup {
  history = true,
  updateevents = 'TextChanged,TextChangedI',
  delete_check_events = 'TextChanged',
  ext_opts = {},
}

local get_cstring = function(ctype)
  local cstring = calculate_comment_string { ctype = ctype, range = region() } or ''
  local cstring_table = vim.split(cstring, '%s', { plain = true, trimempty = true })
  if #cstring_table == 0 then
    return { '', '' }
  end
  return #cstring_table == 1 and { cstring_table[1], '' } or { cstring_table[1], cstring_table[2] }
end

local todo_snippet_nodes = function(aliases, opts)
  local aliases_nodes = vim.tbl_map(function(alias)
    return i(nil, alias)
  end, aliases)
  -- format them into the actual snippet
  local comment_node = fmta('<> <>(liubang): <> <>', {
    f(function()
      return get_cstring(opts.ctype)[1]
    end),
    c(1, aliases_nodes),
    i(2),
    f(function()
      return get_cstring(opts.ctype)[2]
    end),
  })
  return comment_node
end

local todo_snippet = function(context, aliases, opts)
  opts = opts or {}
  aliases = type(aliases) == 'string' and { aliases } or aliases
  context = context or {}
  if not context.trig then
    return error('context doesn\'t include a `trig` key which is mandatory', 2)
  end
  opts.ctype = opts.ctype or 1
  local alias_string = table.concat(aliases, '|')
  context.name = context.name or (alias_string .. ' comment')
  context.dscr = context.dscr or (alias_string .. ' comment with a signature-mark')
  local comment_node = todo_snippet_nodes(aliases, opts)
  return s(context, comment_node, opts)
end

local todo_snippet_specs = {
  { { trig = 'todo' }, 'TODO' },
  { { trig = 'fix' }, { 'FIX', 'BUG', 'ISSUE', 'FIXIT' } },
  { { trig = 'hack' }, 'HACK' },
  { { trig = 'warn' }, { 'WARN', 'WARNING', 'XXX' } },
  { { trig = 'perf' }, { 'PERF', 'PERFORMANCE', 'OPTIM', 'OPTIMIZE' } },
  { { trig = 'note' }, { 'NOTE', 'INFO' } },
  { { trig = 'todob' }, 'TODO', { ctype = 2 } },
  { { trig = 'fixb' }, { 'FIX', 'BUG', 'ISSUE', 'FIXIT' }, { ctype = 2 } },
  { { trig = 'hackb' }, 'HACK', { ctype = 2 } },
  { { trig = 'warnb' }, { 'WARN', 'WARNING', 'XXX' }, { ctype = 2 } },
  { { trig = 'perfb' }, { 'PERF', 'PERFORMANCE', 'OPTIM', 'OPTIMIZE' }, { ctype = 2 } },
  { { trig = 'noteb' }, { 'NOTE', 'INFO' }, { ctype = 2 } },
}

local todo_comment_snippets = {}
for _, v in ipairs(todo_snippet_specs) do
  table.insert(todo_comment_snippets, todo_snippet(v[1], v[2], v[3]))
end

ls.add_snippets('all', todo_comment_snippets, { type = 'snippets', key = 'todo_comments' })

ls.add_snippets('go', {
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
}, { type = 'snippets', key = 'go' })

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
  s({ trig = 'ignore' }, {
    t { '// clang-format off', '' },
    i(1, { '' }),
    t { '', '// clang-format on' },
  }),
}, { type = 'snippets', key = 'cpp' })

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
}, { type = 'snippets', key = 'c' })

ls.add_snippets('lua', {
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
}, { type = 'snippets', key = 'lua' })
