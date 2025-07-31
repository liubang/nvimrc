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
  "brenoprata10/nvim-highlight-colors",
  event = { "CursorHold", "CursorHoldI" },
  opts = {
    render = "background",
    enable_hex = true,
    enable_short_hex = true,
    enable_rgb = true,
    enable_hsl = true,
    enable_var_usage = true,
    enable_named_colors = false,
    enable_tailwind = false,
    -- Exclude filetypes or buftypes from highlighting
    exclude_filetypes = {
      "c",
      "cpp",
      "go",
      "java",
      "alpha",
      "dap-repl",
      "fugitive",
      "git",
      "notify",
      "NvimTree",
      "Outline",
      "TelescopePrompt",
      "toggleterm",
      "undotree",
    },
    exclude_buftypes = {
      "nofile",
      "prompt",
      "terminal",
    },
  },
}
