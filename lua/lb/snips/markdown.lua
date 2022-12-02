--=====================================================================
--
-- markdown.lua -
--
-- Created by liubang on 2022/09/03 03:40
-- Last Modified: 2022/12/03 01:35
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

  ls.s(
    'blogmeta',
    fmt(
      [[
      ---
      title: "{}"
      date: "{}"
      categories:
        - {}
      tags:
        - {}
      ---
      {}
      ]],
      {
        i(1, 'title'),
        i(2, vim.fn.strftime '%Y-%m-%d'),
        i(3),
        i(4),
        i(0),
      }
    )
  ),

  ls.s(
    'alert',
    fmt(
      [[
        {{{{< alert {} >}}}}
        {}
        {{{{< /alert >}}}}
      ]],
      {
        ls.c(1, {
          i(nil, 'info'),
          i(nil, 'success'),
          i(nil, 'warning'),
          i(nil, 'danger'),
        }),
        i(0),
      }
    )
  ),

  ls.s(
    'alertmd',
    fmt(
      [[
      {{{{% alert {} %}}}}
      {}
      {{{{% /alert %}}}}
      ]],
      {
        ls.c(1, {
          i(nil, 'info'),
          i(nil, 'success'),
          i(nil, 'warning'),
          i(nil, 'danger'),
        }),
        i(0),
      }
    )
  ),

  ls.s( -- Codeblock {{{
    'codeblock',
    fmt('```{}\n{}\n```\n{}', {
      ls.c(1, {
        i(nil, 'cpp'),
        i(nil, 'c'),
        i(nil, 'go'),
        i(nil, 'rust'),
        i(nil, 'java'),
        i(nil, 'javascript'),
        i(nil, 'typescript'),
      }),
      ls.i(2),
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
  -- Markdown: Headers
  s({ trig = '^%s*h(%d)', regTrig = true }, {
    f(function(_, snip)
      return string.rep('#', snip.captures[1])
    end),
  }),
})
