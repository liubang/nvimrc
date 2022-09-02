--=====================================================================
--
-- markdown.lua -
--
-- Created by liubang on 2022/09/03 03:40
-- Last Modified: 2022/09/03 03:40
--
--=====================================================================
local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep
local f = ls.function_node

ls.add_snippets('markdown', {
  ls.s( -- Link {{{
    {
      trig = 'link',
      name = 'markdown_link',
      dscr = 'Create markdown link [txt](url).\nSelect link, press C-s, type link.',
    },
    fmt('[{}]({})\n{}', {
      ls.i(1),
      ls.f(function(_, snip)
        return snip.env.TM_SELECTED_TEXT[1] or {}
      end, {}),
      ls.i(0),
    })
  ), --}}}

  ls.s( -- Codeblock {{{
    {
      trig = 'codeblock',
      name = 'Make code block',
      dscr = 'Select text, press <C-s>, type codeblock.',
    },
    fmt('```{}\n{}\n```\n{}', {
      ls.i(1, 'Language'),
      ls.f(function(_, snip)
        local tmp = snip.env.TM_SELECTED_TEXT
        tmp[0] = nil
        return tmp or {}
      end, {}),
      ls.i(0),
    })
  ), --}}}

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
