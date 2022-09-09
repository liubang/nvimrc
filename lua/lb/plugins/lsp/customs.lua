--=====================================================================
--
-- customs.lua -
--
-- Created by liubang on 2022/04/16 22:09
-- Last Modified: 2022/04/16 22:09
--
--=====================================================================
local M = {}
local navic = require 'nvim-navic'

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
custom_capabilities.textDocument.completion.completionItem.snippetSupport = true
custom_capabilities.textDocument.completion.completionItem.preselectSupport = true
custom_capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
custom_capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
custom_capabilities.textDocument.completion.completionItem.deprecatedSupport = true
custom_capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
custom_capabilities.textDocument.completion.completionItem.tagSupport = true
custom_capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

local custom_attach = function(client, bufnr)
  navic.attach(client, bufnr)

  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = 0 })
  vim.keymap.set('n', '<Leader>gD', vim.lsp.buf.declaration, { buffer = 0 })
  vim.keymap.set('n', '<Leader>gd', vim.lsp.buf.definition, { buffer = 0 })
  vim.keymap.set('n', '<Leader>gi', vim.lsp.buf.implementation, { buffer = 0 })
  vim.keymap.set('n', '<Leader>gr', require('telescope.builtin').lsp_references, { buffer = 0 })
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, { buffer = 0 })
  vim.keymap.set('n', '<Leader>ee', function()
    vim.diagnostic.open_float(nil, { scope = 'line' })
  end, { buffer = 0 })

  vim.keymap.set('n', '<Leader>es', function()
    require('telescope.builtin').diagnostics { bufnr = 0 }
  end, { buffer = 0 })

  vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, { buffer = 0 })
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.hover, { buffer = 0, desc = 'lsp:hover' })

  if client.server_capabilities.document_formatting then
    vim.keymap.set('n', '<Leader>fm', vim.lsp.buf.formatting_sync, { buffer = 0 })
    vim.api.nvim_buf_create_user_command(0, 'Format', vim.lsp.buf.formatting_sync, { nargs = 0 })
  end

  if client.server_capabilities.document_range_formatting then
    vim.keymap.set('v', '<Leader>fm', vim.lsp.buf.range_formatting, { buffer = 0 })
  end

  -- disable sumneko_lua format
  if client.name == 'sumneko_lua' then
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
  end

  if client.name == 'jdtls' then
    vim.api.nvim_buf_create_user_command(0, 'JdtOrgImport', require('jdtls').organize_imports, {})
    vim.api.nvim_buf_create_user_command(0, 'JdtBytecode', require('jdtls').javap, {})
    vim.api.nvim_buf_create_user_command(0, 'JdtJshell', require('jdtls').jshell, {})
  end
end

M.default = function(configs)
  local custom_config = {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = custom_capabilities,
  }
  if configs ~= nil then
    for key, value in pairs(configs) do
      custom_config[key] = value
    end
  end
  return custom_config
end

return M
