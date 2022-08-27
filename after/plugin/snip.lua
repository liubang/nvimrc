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
local d = ls.dynamic_node
local snippet_from_nodes = ls.sn
local rep = require('luasnip.extras').rep
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local calculate_comment_string = require('Comment.ft').calculate
local region = require('Comment.utils').get_region
local types = require 'luasnip.util.types'
local author = 'liubang'

ls.config.setup {
  history = true,
  updateevents = 'TextChanged,TextChangedI',
  delete_check_events = 'TextChanged',
  -- Autosnippets:
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { ' « ', 'Comment' } },
      },
    },
  },
  store_selection_keys = '<Tab>',
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

local todo_comment_snippets = {}
for _, v in ipairs(todo_snippet_specs) do
  table.insert(todo_comment_snippets, todo_snippet(v[1], v[2], v[3]))
end

ls.add_snippets('all', todo_comment_snippets, { type = 'snippets', key = 'todo_comments' })

local ts_locals = require 'nvim-treesitter.locals'
local ts_utils = require 'nvim-treesitter.ts_utils'
local get_node_text = vim.treesitter.get_node_text

local transforms = {
  int = function(_, _)
    return t '0'
  end,

  bool = function(_, _)
    return t 'false'
  end,

  string = function(_, _)
    return t [[""]]
  end,

  error = function(_, info)
    if info then
      info.index = info.index + 1

      return c(info.index, {
        t(info.err_name),
        t(string.format('errors.Wrap(%s, "%s")', info.err_name, info.func_name)),
      })
    else
      return t 'err'
    end
  end,

  -- Types with a "*" mean they are pointers, so return nil
  [function(text)
    return string.find(text, '*', 1, true) ~= nil
  end] = function(_, _)
    return t 'nil'
  end,
}
local transform = function(text, info)
  local condition_matches = function(condition, ...)
    if type(condition) == 'string' then
      return condition == text
    else
      return condition(...)
    end
  end

  for condition, result in pairs(transforms) do
    if condition_matches(condition, text, info) then
      return result(text, info)
    end
  end

  return t(text)
end

local handlers = {
  parameter_list = function(node, info)
    local result = {}

    local count = node:named_child_count()
    for idx = 0, count - 1 do
      local matching_node = node:named_child(idx)
      local type_node = matching_node:field('type')[1]
      table.insert(result, transform(get_node_text(type_node, 0), info))
      if idx ~= count - 1 then
        table.insert(result, t { ', ' })
      end
    end

    return result
  end,

  type_identifier = function(node, info)
    local text = get_node_text(node, 0)
    return { transform(text, info) }
  end,
}

local function_node_types = {
  function_declaration = true,
  method_declaration = true,
  func_literal = true,
}

local function go_result_type(info)
  local cursor_node = ts_utils.get_node_at_cursor()
  local scope = ts_locals.get_scope_tree(cursor_node, 0)

  local function_node
  for _, v in ipairs(scope) do
    if function_node_types[v:type()] then
      function_node = v
      break
    end
  end

  if not function_node then
    print 'Not inside of a function'
    return t ''
  end

  local query = vim.treesitter.parse_query(
    'go',
    [[
      [
        (method_declaration result: (_) @id)
        (function_declaration result: (_) @id)
        (func_literal result: (_) @id)
      ]
    ]]
  )
  for _, node in query:iter_captures(function_node, 0) do
    if handlers[node:type()] then
      return handlers[node:type()](node, info)
    end
  end
end
local go_ret_vals = function(args)
  return snippet_from_nodes(
    nil,
    go_result_type {
      index = 0,
      err_name = args[1][1],
      func_name = args[2][1],
    }
  )
end
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
  s(
    'efi',
    fmta(
      [[
<val>, <err> := <f>(<args>)
if <err_same> != nil {
	return <result>
}
<finish>
]],
      {
        val = i(1),
        err = i(2, 'err'),
        f = i(3),
        args = i(4),
        err_same = rep(2),
        result = d(5, go_ret_vals, { 2, 3 }),
        finish = i(0),
      }
    )
  ),
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
  s({ trig = 'formatoff' }, {
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
  s({ trig = 'formatoff' }, {
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

ls.add_snippets('markdown', {
  -- Markdown: Definition comment tag
  s(
    'defn',
    fmt(
      [[
          <!-- Definition: {} -->

          > **{}:** {}
      ]],
      {
        i(1),
        rep(1),
        i(0),
      }
    )
  ),
  -- Markdown: Embed image
  s('img', {
    t '![](./',
    i(0),
    t ')',
  }),
  -- Markdown: Left arrow
  s('<-', t '←'),
  -- Markdown: Right arrow
  s('->', t '→'),
  -- Markdown: Left double arrow
  s('<=', t '⇐'),
  -- Markdown: Right double arrow
  s('=>', t '⇒'),
  -- Markdown: Less than or equal to
  s('<=', t '≤'),
  -- Markdown: Greater than or equal to
  s('>=', t '≥'),
  -- Markdown: Headers
  s({ trig = '^%s*h(%d)', regTrig = true }, {
    f(function(_, snip)
      return string.rep('#', snip.captures[1])
    end),
  }),
})

vim.keymap.set({ 'i', 's' }, '<C-n>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

vim.keymap.set({ 'i', 's' }, '<C-p>', function()
  if ls.choice_active() then
    ls.change_choice(-1)
  end
end)
