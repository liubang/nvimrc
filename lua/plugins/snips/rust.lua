--=====================================================================
--
-- rust.lua -
--
-- Created by liubang on 2022/11/12 23:13
-- Last Modified: 2022/12/06 22:22
--
--=====================================================================

local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("rust", {
  s(
    "main",
    fmt(
      [[
      fn main() {
          <>
      }
      ]],
      { i(1, 'println!("hello world")') },
      { delimiters = "<>" }
    )
  ),
  s(
    { trig = "testmod", name = "Create a test module" },
    fmt(
      [[
      #[cfg(test)]
      mod {} {{
          use super::*;

          #[test]
          fn {}() {{
              {}
          }}
      }}
    ]],
      {
        ls.i(1),
        ls.i(2),
        ls.i(0),
      }
    )
  ),
  s("derivedebug", t "#[derive(Debug)]"),
  s("deadcode", t "#[allow(dead_code)]"),
  s("allowfreedom", t "#![allow(clippy::disallowed_names, unused_variables, dead_code)]"),

  s("clippypedantic", t "#![warn(clippy::all, clippy::pedantic)]"),

  s(":turbofish", { t { "::<" }, i(0), t { ">" } }),

  s("print", {
    -- t {'println!("'}, i(1), t {' {:?}", '}, i(0), t {');'}}),
    t { 'println!("' },
    i(1),
    t { " {" },
    i(0),
    t { ':?}");' },
  }),

  s("for", {
    t { "for " },
    i(1),
    t { " in " },
    i(2),
    t { " {", "" },
    i(0),
    t { "}", "" },
  }),

  s("struct", {
    t { "#[derive(Debug)]", "" },
    t { "struct " },
    i(1),
    t { " {", "" },
    i(0),
    t { "}", "" },
  }),

  s("test", {
    t { "#[test]", "" },
    t { "fn " },
    i(1),
    t { "() {", "" },
    t { "	assert" },
    i(0),
    t { "", "" },
    t { "}" },
  }),

  s("testcfg", {
    t { "#[cfg(test)]", "" },
    t { "mod " },
    i(1),
    t { " {", "" },
    t { "	#[test]", "" },
    t { "	fn " },
    i(2),
    t { "() {", "" },
    t { "		assert" },
    i(0),
    t { "", "" },
    t { "	}", "" },
    t { "}" },
  }),

  s("if", {
    t { "if " },
    i(1),
    t { " {", "" },
    i(0),
    t { "}" },
  }),
})
