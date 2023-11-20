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
    local client = function()
      return vim.lsp.get_active_clients({ name = "gopls" })
    end
    require("plugins.lsp.utils").codeaction(client(), "", "source.organizeImports", 1000)
    require("plugins.lsp.format").format()
  end,
})

-- vim: foldmethod=marker foldlevel=0
