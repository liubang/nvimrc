local M = {}

-- define commands
vim.schedule(function()
  vim.cmd [[command! -buffer -nargs=0 Format :lua vim.lsp.buf.formatting_sync()]]
  vim.cmd [[command! -buffer JdtOrgImport :lua require'jdtls'.organize_imports()]]
  vim.cmd [[command! -buffer JdtBytecode lua require'jdtls'.javap()]]
  vim.cmd [[command! -buffer JdtJshell lua require'jdtls'.jshell()]]
end)

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
custom_capabilities = require('cmp_nvim_lsp').update_capabilities(custom_capabilities)

local custom_attach = function(client, _)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = 0 })
  vim.keymap.set('n', '<Leader>gD', vim.lsp.buf.declaration, { buffer = 0 })
  vim.keymap.set('n', '<Leader>gd', vim.lsp.buf.definition, { buffer = 0 })
  vim.keymap.set('n', '<Leader>gi', vim.lsp.buf.implementation, { buffer = 0 })
  vim.keymap.set('n', '<Leader>gr', require('telescope.builtin').lsp_references, { buffer = 0 })
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, { buffer = 0 })
  vim.keymap.set(
    'n',
    '<Leader>ee',
    require('lspsaga.diagnostic').show_line_diagnostics,
    { buffer = 0 }
  )
  vim.keymap.set('n', '<Leader>ef', function()
    require('telescope.builtin').diagnostics { bufnr = 0 }
  end, { buffer = 0 })
  vim.keymap.set('n', '<Leader>ca', require('lspsaga.codeaction').code_action, { buffer = 0 })
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.hover, { buffer = 0 })
  if client.resolved_capabilities.document_formatting then
    vim.keymap.set('n', '<Leader>fm', vim.lsp.buf.formatting_sync, { buffer = 0 })
  end
  if client.resolved_capabilities.document_range_formatting then
    vim.keymap.set('v', '<Leader>fm', vim.lsp.buf.range_formatting, { buffer = 0 })
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
