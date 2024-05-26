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
  "nvim-lualine/lualine.nvim", -- {{{
  event = "VeryLazy",
  opts = function()
    return {
      options = {
        theme = "auto",
        globalstatus = true,
        icons_enabled = true,
        component_separators = "",
        section_separators = "",
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { require("lb.utils.util").mode_format },
        lualine_b = {
          { "branch", icon = "\u{e725}" },
          { "diff" },
          { "diagnostics", colored = true },
        },
        lualine_c = {
          {
            "filename",
            path = 1,
            file_status = true,
            shorting_target = 40,
            symbols = {
              modified = " \u{f040}",
              readonly = " \u{f023}",
              unnamed = "[No Name]",
            },
            cond = function()
              local f = vim.fn.expand("%:p")
              return f:len() <= 6 or f:sub(0, 6) ~= "jdt://"
            end,
          },
          {
            require("lb.utils.util").file_size_format,
            cond = function()
              local ft = vim.api.nvim_buf_get_option(0, "filetype")
              if ft == "alpha" or ft == "NvimTree" or ft == "aerial" then
                return false
              end
              return true
            end,
          },
          {
            function()
              return require("nvim-navic").get_location()
            end,
            cond = function()
              return require("nvim-navic").is_available()
            end,
          },
        },
        lualine_x = {
          require("lb.utils.util").lineinfo,
          {
            require("lb.utils.util").lsp_clients_format,
            cond = function()
              local ft = vim.api.nvim_buf_get_option(0, "filetype")
              if ft == "alpha" or ft == "NvimTree" or ft == "aerial" then
                return false
              end
              local get_clients = (
                vim.lsp.get_clients ~= nil and vim.lsp.get_clients -- nvim 0.10+
                or vim.lsp.get_active_clients
              )
              return next(get_clients({ bufnr = 0 })) ~= nil
            end,
          },
        },
        lualine_y = {
          { "filetype", icon_only = true, colored = true },
          { "encoding" },
        },
        lualine_z = {
          {
            "fileformat",
            icons_enabled = true,
            symbols = {
              unix = " UNIX",
              dos = " WIN",
              mac = " OSX",
            },
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "nvim-tree" },
    }
  end,
  -- }}}
}
