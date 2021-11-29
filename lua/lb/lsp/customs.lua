local nnoremap = vim.keymap.nnoremap
local vnoremap = vim.keymap.vnoremap
local M = {}


-- define commands
vim.schedule(function()
  vim.cmd [[command! -nargs=0 Format :lua vim.lsp.buf.formatting_sync()]]
end)

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
custom_capabilities.textDocument.codeLens = { dynamicRegistration = false }
custom_capabilities = require('cmp_nvim_lsp').update_capabilities(custom_capabilities)

-- custom attach function
local buf_nnoremap = function(opts)
  opts.buffer = 0
  nnoremap(opts)
end

local buf_vnoremap = function(opts)
  opts.buffer = 0
  vnoremap(opts)
end

local custom_attach = function(client, _)
  buf_nnoremap { '<Leader>gD', vim.lsp.buf.declaration }
  buf_nnoremap { '<Leader>gd', vim.lsp.buf.definition }
  buf_nnoremap { '<Leader>gi', vim.lsp.buf.implementation }
  buf_nnoremap { '<Leader>gr', require('telescope.builtin').lsp_references }
  buf_nnoremap { '<Leader>hh', vim.lsp.buf.signature_help }
  buf_nnoremap { '<Leader>rn', vim.lsp.buf.rename }
  buf_nnoremap { '<Leader>ee', require('lspsaga.diagnostic').show_line_diagnostics }
  buf_nnoremap { '<Leader>ef', require('telescope.builtin').lsp_document_diagnostics }
  buf_nnoremap { '<Leader>ca', require('telescope.builtin').lsp_code_actions }
  buf_vnoremap {
    '<Leader>ca',
    ':<C-U>lua require("telescope.builtin").lsp_range_code_actions()<CR>',
  }
  buf_nnoremap { 'K', vim.lsp.buf.hover }
  if client.resolved_capabilities.document_formatting then
    buf_nnoremap { '<Leader>fm', vim.lsp.buf.formatting_sync }
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_vnoremap { '<Leader>fm', vim.lsp.buf.range_formatting }
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
