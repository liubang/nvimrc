--=====================================================================
--
-- git.lua -
--
-- Created by liubang on 2022/03/02 16:58
-- Last Modified: 2022/10/18 23:28
--
--=====================================================================

local gitsigns = require "gitsigns"

-- stylua: ignore start
gitsigns.setup({
  signs = {
    add          = { text = "▌", show_count = true },
    change       = { text = "▌", show_count = true },
    delete       = { text = "▐", show_count = true },
    topdelete    = { text = "▛", show_count = true },
    changedelete = { text = "▚", show_count = true },
  },
  sign_priority = 10,
  count_chars = {
    [1] = "",
    [2] = "₂",
    [3] = "₃",
    [4] = "₄",
    [5] = "₅",
    [6] = "₆",
    [7] = "₇",
    [8] = "₈",
    [9] = "₉",
    ["+"] = "₊",
  },

  diff_opts = {
    internal = true,
    algorithm = "patience",
    indent_heuristic = true,
    linematch = 60,
  },

  -- on_attach = function(bufnr)
  --   local name = vim.api.nvim_buf_get_name(bufnr)
  --   if vim.fn.expand("%:t") == "lsp.log" or vim.bo.filetype == "help" then
  --     return false
  --   end
  --   local size = vim.fn.getfsize(name)
  --   if size > 1024 * 1024 * 5 then
  --     return false
  --   end
  -- end,
})
-- stylua: ignore end
