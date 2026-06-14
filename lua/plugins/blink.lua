-- Copyright (c) 2025 The Authors. All rights reserved.
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
  "saghen/blink.cmp",
  event = { "InsertEnter" },
  dependencies = {
    "saghen/blink.lib",
    "L3MON4D3/LuaSnip",
  },
  build = function()
    require("blink.cmp").build():pwait()
  end,
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.default",
  },
  opts = {
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "lazydev", "snippets", "buffer", "path" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        cmdline = {
          min_keyword_length = function(ctx)
            if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
              return 3
            end
            return 0
          end,
        },
      },
    },
    completion = {
      documentation = { auto_show = false },
      ghost_text = { enabled = false },
      list = {
        selection = { preselect = true, auto_insert = true },
      },
      menu = {
        draw = {
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
        },
      },
    },
    cmdline = {
      enabled = true,
      keymap = { preset = "cmdline" },
    },
    fuzzy = {
      implementation = "rust",
    },
    signature = { enabled = false },
    keymap = {
      preset = "enter",
      ["<Up>"] = {},
      ["<Down>"] = {},
      ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
      ["<C-j>"] = { "select_next", "fallback_to_mappings" },
    },
  },
}
