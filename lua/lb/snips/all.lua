--=====================================================================
--
-- all.lua -
--
-- Created by liubang on 2022/09/03 03:36
-- Last Modified: 2022/09/03 03:36
--
--=====================================================================

local ls = require 'luasnip'
local util = require 'lb.utils.util'
-- some shorthands...
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local F = require('luasnip.nodes.functionNode').F
local fmta = require('luasnip.extras.fmt').fmta
local calculate_comment_string = require('Comment.ft').calculate
local region = require('Comment.utils').get_region
local author = 'liubang'

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
  local comment_node = fmta('<> <>(' .. author .. '): <> <>', {
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
  { { trig = 'warn' }, { 'WARN', 'WARNING' } },
  { { trig = 'perf' }, { 'PERF', 'PERFORMANCE', 'OPTIM', 'OPTIMIZE' } },
  { { trig = 'note' }, { 'NOTE', 'INFO' } },
  { { trig = 'todob' }, 'TODO', { ctype = 2 } },
  { { trig = 'fixb' }, { 'FIX', 'BUG', 'ISSUE', 'FIXIT' }, { ctype = 2 } },
  { { trig = 'hackb' }, 'HACK', { ctype = 2 } },
  { { trig = 'warnb' }, { 'WARN', 'WARNING' }, { ctype = 2 } },
  { { trig = 'perfb' }, { 'PERF', 'PERFORMANCE', 'OPTIM', 'OPTIMIZE' }, { ctype = 2 } },
  { { trig = 'noteb' }, { 'NOTE', 'INFO' }, { ctype = 2 } },
}

local partial = function(func, ...)
  return F(function(_, _, ...)
    return func(...)
  end, {}, { user_args = { ... } })
end

local snippets = {
  ls.s('time', partial(vim.fn.strftime, '%H:%M:%S')),
  ls.s('date', partial(vim.fn.strftime, '%Y-%m-%d')),
  ls.s('pwd', { partial(util.shell, 'pwd') }),
  ls.s({ trig = 'uuid', wordTrig = true }, { ls.f(util.uuid), ls.i(0) }),
  ls.s('shrug', { ls.t '¯\\_(ツ)_/¯' }),
  ls.s('angry', { ls.t '(╯°□°）╯︵ ┻━┻' }),
  ls.s('happy', { ls.t 'ヽ(´▽`)/' }),
  ls.s('sad', { ls.t '(－‸ლ)' }),
  ls.s('confused', { ls.t '(｡･ω･｡)' }),
  ls.s({ trig = 'rstr(%d+)', regTrig = true }, {
    ls.f(function(_, snip)
      return util.random_string(snip.captures[1])
    end),
    ls.i(0),
  }),
}

for _, v in ipairs(todo_snippet_specs) do
  table.insert(snippets, todo_snippet(v[1], v[2], v[3]))
end

ls.add_snippets('all', snippets, { type = 'snippets', key = 'todo_comments' })
