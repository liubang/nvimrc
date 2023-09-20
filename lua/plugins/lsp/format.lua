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
  lua = true,
  -- bzl = true,
}

function M.format()
  local bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.bo[bufnr].filetype
  local have_nls = #require("null-ls.sources").get_available(filetype, "NULL_LS_FORMATTING") > 0
  local filter = function(client)
    if have_nls then
      return client.name == "null-ls"
    end
    return client.name ~= "null-ls"
  end
  vim.lsp.buf.format { async = false, bufnr = bufnr, filter = filter }
end

function M.on_attach(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  if client.supports_method "textDocument/formatting" then
    vim.keymap.set("n", "<Leader>fm", function()
      M.format()
    end, opts)

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

  if client.supports_method "textDocument/rangeFormatting" then
    vim.keymap.set("v", "<Leader>fm", function()
      M.format()
    end, opts)
  end
end

return M
