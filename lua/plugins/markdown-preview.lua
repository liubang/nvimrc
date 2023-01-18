--=====================================================================
--
-- markdown-preview.lua -
--
-- Created by liubang on 2022/12/30 21:51
-- Last Modified: 2022/12/30 21:51
--
--=====================================================================
return {
  "iamcco/markdown-preview.nvim",
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  keys = {
    { "<Leader>mp", "<CMD>MarkdownPreview<CR>", mode = { "n" }, desc = "Open markdown preview window" },
  },
}

-- vim: fdm=marker fdl=0
