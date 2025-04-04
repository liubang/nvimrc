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
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      require("lazy").load({ plugins = { "markdown-preview.nvim" } })
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.cmd([[do FileType]])
    end,
    -- stylua: ignore
    keys = {
      { "<Leader>mp", "<CMD>MarkdownPreview<CR>", desc = "Markdown Preview" },
    },
  },
  -- {
  --   "MeanderingProgrammer/render-markdown.nvim",
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "echasnovski/mini.icons",
  --   }, -- if you use standalone mini plugins
  --   ft = { "markdown" },
  --   opts = {
  --     enabled = true,
  --     completions = { blink = { enabled = true } },
  --     -- Maximum file size (in MB) that this plugin will attempt to render
  --     -- Any file larger than this will effectively be ignored
  --     max_file_size = 2.0,
  --     -- Milliseconds that must pass before updating marks, updates occur
  --     -- within the context of the visible window, not the entire buffer
  --     debounce = 100,
  --     -- Vim modes that will show a rendered view of the markdown file
  --     -- All other modes will be uneffected by this plugin
  --     render_modes = { "n", "c", "t" },
  --     -- This enables hiding any added text on the line the cursor is on
  --     -- This does have a performance penalty as we must listen to the 'CursorMoved' event
  --     anti_conceal = { enabled = true },
  --     -- The level of logs to write to file: vim.fn.stdpath('state') .. '/render-markdown.log'
  --     -- Only intended to be used for plugin development / debugging
  --     log_level = "error",
  --   },
  -- },
}
