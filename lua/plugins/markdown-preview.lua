--=====================================================================
--
-- markdown-preview.lua -
--
-- Created by liubang on 2022/12/30 21:51
-- Last Modified: 2023/01/29 11:13
--
--=====================================================================
return {
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    enabled = function()
      return vim.fn.executable "deno" == 0 and vim.fn.executable "npm" == 1
    end,
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    keys = {
      {
        "<Leader>mp",
        "<CMD>MarkdownPreview<CR>",
        desc = "Markdown Preview",
      },
    },
  },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    enabled = function()
      return vim.fn.executable "deno" == 1
    end,
    ft = { "markdown" },
    keys = {
      {
        "<leader>mp",
        function()
          local peek = require "peek"
          if peek.is_open() then
            peek.close()
          else
            peek.open()
          end
        end,
        desc = "Peek (Markdown Preview)",
      },
    },
    opts = { theme = "light" },
  },
}

-- vim: fdm=marker fdl=0
