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
  "folke/noice.nvim",
  event = "VeryLazy",
  enabled = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    cmdline = {
      -- enabled = false,
      format = {
        cmdline = { icon = ">" },
        search_down = {
          view = "cmdline",
        },
        search_up = {
          view = "cmdline",
        },
      },
      view = "cmdline",
    },
    messages = { enabled = true },
    popupmenu = { enabled = false },
    notify = { enabled = false },
    lsp = {
      progress = { enabled = true },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
        ["vim.lsp.util.stylize_markdown"] = false,
        ["cmp.entry.get_documentation"] = false,
      },
      signature = { enabled = false },
    },
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = false, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    views = {
      confirm = {
        backend = "popup",
        relative = "editor",
        focusable = false,
        align = "center",
        enter = false,
        zindex = 210,
        format = { "{confirm}" },
        position = {
          row = "40%",
          col = "50%",
        },
        size = "auto",
        border = {
          style = "single",
          padding = { 1, 3 },
          text = {
            top = " Confirm ",
          },
        },
        win_options = {
          winhighlight = {
            Normal = "NoiceConfirm",
            FloatBorder = "Comment",
          },
          winbar = "",
          foldenable = false,
        },
      },
    },
    routes = {
      {
        filter = {
          event = "lsp",
          kind = "progress",
          cond = function(message)
            return "null-ls" == vim.tbl_get(message.opts, "progress", "client")
          end,
        },
        opts = { skip = true },
      },
    },
  },
}
