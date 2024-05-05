-- Copyright (c) 2024 The Authors. All rights reserved.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      https://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- Authors: liubang (it.liubang@gmail.com)

return {
  "gbprod/yanky.nvim", -- {{{
  dependencies = { "kkharji/sqlite.lua" },
  keys = {
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" } },
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" } },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" } },
  },
  opts = {
    system_clipboard = {
      sync_with_ring = true,
    },
    highlight = {
      on_put = true,
      on_yank = true,
      timer = 350,
    },
    ring = { storage = jit.os:find("Windows") and "shada" or "sqlite" },
  },
  -- }}}
}
