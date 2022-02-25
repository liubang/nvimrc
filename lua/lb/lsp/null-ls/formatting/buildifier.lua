--=====================================================================
--
-- buildifier.lua -
--
-- Created by liubang on 2022/02/25 15:11
-- Last Modified: 2022/02/25 15:11
--
--=====================================================================
local h = require 'null-ls.helpers'
local methods = require 'null-ls.methods'

local FORMATTING = methods.internal.FORMATTING

return h.make_builtin {
  name = 'buildifier',
  method = FORMATTING,
  filetypes = { 'bazel', 'bzl' },
  generator_opts = {
    command = 'buildifier',
    to_stdin = true,
  },
  factory = h.formatter_factory,
}
