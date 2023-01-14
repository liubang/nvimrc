--=====================================================================
--
-- customs.lua -
--
-- Created by liubang on 2022/04/16 22:09
-- Last Modified: 2022/12/01 22:26
--
--=====================================================================

local M = {}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local autoformats = {
  rust = true,
  bzl = true,
  lua = true,
}

local augroup_format = vim.api.nvim_create_augroup("my_lsp_format", { clear = true })

local format = function()
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

local custom_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  -- common keymaps
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "<Leader>gd", "<cmd>Telescope lsp_definitions<CR>", bufopts)
  vim.keymap.set("n", "<Leader>gi", "<cmd>Telescope lsp_implementations<CR>", bufopts)
  vim.keymap.set("n", "<Leader>gr", "<cmd>Telescope lsp_references<CR>", bufopts)
  vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<Leader>ee", function()
    vim.diagnostic.open_float(nil, { scope = "line" })
  end, bufopts)
  vim.keymap.set("n", "<Leader>es", "<cmd>Telescope diagnostics bufnr=0<CR>", bufopts)
  vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.hover, bufopts)

  -- filetype config
  if client.supports_method "textDocument/formatting" then
    vim.keymap.set("n", "<Leader>fm", function()
      format()
    end, { noremap = true, silent = true, buffer = bufnr })

    -- auto format
    if autoformats[vim.bo[bufnr].filetype] then
      vim.api.nvim_clear_autocmds { buffer = bufnr, group = augroup_format }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup_format,
        buffer = bufnr,
        callback = function()
          format()
        end,
      })
    end
  end
end

M.default = function(configs)
  local custom_config = {
    on_attach = custom_attach,
    capabilities = capabilities,
  }
  if configs ~= nil then
    for key, value in pairs(configs) do
      custom_config[key] = value
    end
  end
  return custom_config
end

return M
