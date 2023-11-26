--=====================================================================
--
-- markdown-preview.lua -
--
-- Created by liubang on 2023/11/26 15:38
-- Last Modified: 2023/11/26 15:38
--
--=====================================================================

return {
  "iamcco/markdown-preview.nvim", -- {{{
  ft = { "markdown" },
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
  -- }}}
}
