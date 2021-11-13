local M = {}

require('lspkind').init()

-- define commands
vim.schedule(function()
  vim.cmd [[command! -nargs=0 Format :lua vim.lsp.buf.formatting()]]
end)

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
custom_capabilities.textDocument.codeLens = {dynamicRegistration = false}
custom_capabilities= require('cmp_nvim_lsp').update_capabilities(custom_capabilities)

-- local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
-- custom_capabilities.textDocument.codeLens = {dynamicRegistration = false}
-- custom_capabilities.textDocument.completion.completionItem.snippetSupport = true
-- custom_capabilities.textDocument.completion.completionItem.resolveSupport =
--   {properties = {'documentation', 'detail', 'additionalTextEdits'}}

-- custom attach function
local opts = {noremap = true, silent = true}
local function buf_set_keymap(...)
  vim.api.nvim_buf_set_keymap(0, ...)
end
-- LuaFormatter off
local custom_attach = function(client, _)
  buf_set_keymap('n', '<Leader>gD', ':lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<Leader>gd', ':lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>gi', ':lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<Leader>gr', ':lua require("telescope.builtin").lsp_references()<CR>', opts)
  buf_set_keymap('n', '<Leader>hh', ':lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Leader>rn', ':lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Leader>ee', ':lua require("lspsaga.diagnostic").show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<Leader>ef', ':lua require("telescope.builtin").lsp_document_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<Leader>ca', ':lua require("telescope.builtin").lsp_code_actions()<CR>', opts)
  buf_set_keymap('v', '<Leader>ca', ':<C-U>lua require("telescope.builtin").lsp_range_code_actions()<CR>', opts)
  buf_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', opts)
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap('n', '<Leader>fm', ':lua vim.lsp.buf.formatting()<CR>', opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap('v', '<Leader>fm', ':<C-U>lua vim.lsp.buf.range_formatting()<CR>', opts)
  end
end
-- LuaFormatter on

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
