--=====================================================================
--
-- lua.lua -
--
-- Created by liubang on 2022/09/03 03:39
-- Last Modified: 2022/09/03 03:39
--
--=====================================================================

local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt
local util = require 'settings.luasnip.util'

ls.add_snippets('lua', {
  ls.s( -- Ignore stylua {{{
    { trig = 'ignore', name = 'Ignore Stylua' },
    fmt('-- stylua: ignore {}\n{}', {
      ls.c(1, {
        ls.t 'start',
        ls.t 'end',
      }),
      ls.i(0),
    })
  ), --}}}

  ls.s( -- Function {{{
    { trig = 'fn', dsce = 'create a function' },
    fmt(
      [[
      {} {}({})
        {}
      end
    ]],
      {
        ls.c(1, {
          ls.t 'function',
          ls.t 'local function',
        }),
        ls.i(2),
        ls.i(3),
        ls.i(0),
      }
    )
  ), --}}}
  ls.s( -- Require Module {{{
    { trig = 'req', name = 'Require', dscr = 'Choices are on the variable name' },
    fmt([[local {} = require("{}")]], {
      ls.d(2, util.last_lua_module_section, { 1 }),
      ls.i(1),
    })
  ), --}}}
})
