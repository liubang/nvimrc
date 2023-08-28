--=====================================================================
--
-- autocmd.lua -
--
-- Created by liubang on 2022/10/18 00:38
-- Last Modified: 2022/12/10 20:49
--
--=====================================================================

local lsp_events_group = vim.api.nvim_create_augroup("LSP_EVENTS", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = lsp_events_group,
  pattern = "*.go",
  callback = function()
    require("lb.utils.lsp").lsp_organise_imports()
  end,
})

-- vim: foldmethod=marker foldlevel=0
