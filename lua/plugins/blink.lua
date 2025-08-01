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
  version = "*",
  event = { "InsertEnter" },
  dependencies = {
    { "L3MON4D3/LuaSnip" },
    { "archie-judd/blink-cmp-words" },
  },
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.default",
  },
  opts = {
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "lazydev", "snippets", "buffer", "path" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
    completion = {
      documentation = { auto_show = false },
      list = {
        selection = { preselect = true, auto_insert = true },
      },
      menu = {
        draw = {
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
        },
      },
    },
    cmdline = { enabled = false },
    fuzzy = {
      implementation = "prefer_rust_with_warning",
      use_frecency = true,
      use_proximity = false,
      prebuilt_binaries = {
        ignore_version_mismatch = true,
      },
      sorts = {
        "score", -- Primary sort: by fuzzy matching score
        "sort_text", -- Secondary sort: by sortText field if scores are equal
        "label", -- Tertiary sort: by label if still tied
      },
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
