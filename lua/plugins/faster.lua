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
  "pteroctopus/faster.nvim",
  lazy = false,
  opts = {
    behaviours = {
      bigfile = {
        on = true,
        features_disabled = {
          -- "lsp",
          "filetype",
          "indent_blankline",
          "matchparen",
          "syntax",
          "treesitter",
          "vimopts",
        },
        filesize = 2,
        extra_patterns = {
          { filesize = 0.3, pattern = "*.cpp" },
        },
      },
      fastmacro = {
        on = true,
        features_disabled = { "lualine" },
      },
    },
    features = {
      -- Neovim filetype plugin
      -- https://neovim.io/doc/user/filetype.html
      filetype = {
        on = true,
        defer = true,
      },
      -- Indent Blankline
      -- https://github.com/lukas-reineke/indent-blankline.nvim
      indent_blankline = {
        on = true,
        defer = false,
      },
      -- Neovim LSP
      -- https://neovim.io/doc/user/lsp.html
      lsp = {
        on = true,
        defer = false,
      },
      -- Lualine
      -- https://github.com/nvim-lualine/lualine.nvim
      lualine = {
        on = true,
        defer = false,
      },
      -- Neovim Pi_paren plugin
      -- https://neovim.io/doc/user/pi_paren.html
      matchparen = {
        on = true,
        defer = false,
      },
      -- Neovim syntax
      -- https://neovim.io/doc/user/syntax.html
      syntax = {
        on = true,
        defer = true,
      },
      -- Neovim treesitter
      -- https://neovim.io/doc/user/treesitter.html
      treesitter = {
        on = true,
        defer = false,
      },
      -- Neovim options that affect speed when big file is opened:
      -- swapfile, foldmethod, undolevels, undoreload, list
      vimopts = {
        on = true,
        defer = false,
      },
    },
  },
}
