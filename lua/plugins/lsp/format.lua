--=====================================================================
--
-- format.lua -
--
-- Created by liubang on 2023/01/25 01:24
-- Last Modified: 2023/01/25 01:24
--
--=====================================================================
local M = {}

local autoformats = {
  rust = true,
  bzl = true,
  lua = true,
}

function M.format()
  local bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.bo[bufnr].filetype
  local have_nls = #require("null-ls.sources").get_available(filetype, "NULL_LS_FORMATTING") > 0
  vim.lsp.buf.format {
    bufnr = bufnr,
    filter = function(client)
      if have_nls then
        return client.name == "null-ls"
      end
      return client.name ~= "null-ls"
    end,
  }
end

function M.on_attach(client, bufnr)
  if client.supports_method "textDocument/formatting" then
    vim.keymap.set("n", "<Leader>fm", function()
      M.format()
    end, { noremap = true, silent = true, buffer = bufnr })

    -- auto format
    if autoformats[vim.bo[bufnr].filetype] then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, {}),
        buffer = bufnr,
        callback = function()
          M.format()
        end,
      })
    end
  end
end

return M
