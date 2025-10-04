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
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    version = "*",
    config = function()
      local presets = require("markview.presets")
      require("markview").setup({
        markdown = {
          headings = presets.headings.marker,
          tables = presets.tables.single,
          code_blocks = {
            enable = true,
            style = "block",
            sign = false,
          },
        },

        preview = {
          enable = false,
          icon_provider = "mini",
        },
      })
    end,
    keys = {
      {
        "<Leader>mp",
        function()
          vim.api.nvim_command("Markview Toggle")
          vim.api.nvim_command("Markview splitToggle")
        end,
        desc = "Markdown Preview",
      },
    },
  },
}
