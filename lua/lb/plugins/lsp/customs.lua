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
custom_capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = 1 }
custom_capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

local augroup_format = vim.api.nvim_create_augroup('my_lsp_format', { clear = true })
local autocmd_format = function(async, filter)
  vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
  vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = 0,
    callback = function()
      vim.lsp.buf.format { async = async, filter = filter }
    end,
  })
end

local filetype_attach = setmetatable({
  cpp = function(client, bufnr)
    navic.attach(client, bufnr)
    vim.keymap.set('n', '<Leader>fm', function()
      vim.lsp.buf.format { async = false }
    end, { noremap = true, silent = true, buffer = bufnr })
  end,

  go = function(client, bufnr)
    navic.attach(client, bufnr)
    vim.keymap.set('n', '<Leader>fm', function()
      vim.lsp.buf.format { async = false }
    end, { noremap = true, silent = true, buffer = bufnr })
  end,

  rust = function(client, bufnr)
    navic.attach(client, bufnr)
    autocmd_format(false)
    vim.keymap.set('n', '<Leader>fm', function()
      vim.lsp.buf.format { async = false }
    end, { noremap = true, silent = true, buffer = bufnr })
  end,

  yaml = function(client, bufnr)
    if client.name ~= 'null-ls' then
      navic.attach(client, bufnr)
    end

    -- autocmd_format(false, function(c)
    --   return c.name == 'null-ls'
    -- end)

    vim.keymap.set('n', '<Leader>fm', function()
      vim.lsp.buf.format {
        async = false,
        filter = function(c)
          return c.name == 'null-ls'
        end,
      }
    end, { noremap = true, silent = true, buffer = bufnr })
  end,

  javascript = function(client, bufnr)
    if client.name ~= 'null-ls' then
      navic.attach(client, bufnr)
    end

    vim.keymap.set('n', '<Leader>fm', function()
      vim.lsp.buf.format {
        async = false,
        filter = function(c)
          return c.name == 'null-ls'
        end,
      }
    end, { noremap = true, silent = true, buffer = bufnr })
  end,

  typescript = function(client, bufnr)
    if client.name ~= 'null-ls' then
      navic.attach(client, bufnr)
    end

    vim.keymap.set('n', '<Leader>fm', function()
      vim.lsp.buf.format {
        async = false,
        filter = function(c)
          return c.name == 'null-ls'
        end,
      }
    end, { noremap = true, silent = true, buffer = bufnr })
  end,

  typescriptreact = function(client, bufnr)
    if client.name ~= 'null-ls' then
      navic.attach(client, bufnr)
    end

    vim.keymap.set('n', '<Leader>fm', function()
      vim.lsp.buf.format {
        async = false,
        filter = function(c)
          return c.name == 'null-ls'
        end,
      }
    end, { noremap = true, silent = true, buffer = bufnr })
  end,

  lua = function(client, bufnr)
    if client.name ~= 'null-ls' then
      navic.attach(client, bufnr)
    end

    -- disable sumneko_lua format
    if client.name == 'sumneko_lua' then
      client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
      client.server_capabilities.documentRangeFormattingProvider = false
    end

    autocmd_format(false, function(c)
      return c.name == 'null-ls'
    end)

    vim.keymap.set('n', '<Leader>fm', function()
      vim.lsp.buf.format {
        async = false,
        filter = function(c)
          return c.name == 'null-ls'
        end,
      }
    end, { noremap = true, silent = true, buffer = bufnr })
  end,
}, {
  __index = function()
    return function(client, bufnr) end
  end,
})

local custom_attach = function(client, bufnr)
  local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- common keymaps
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<Leader>gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<Leader>gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<Leader>gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<Leader>gr', '<cmd>Telescope lsp_references<CR>', bufopts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<Leader>ee', function()
    vim.diagnostic.open_float(nil, { scope = 'line' })
  end, bufopts)
  vim.keymap.set('n', '<Leader>es', '<cmd>Telescope diagnostics bufnr=0<CR>', bufopts)
  vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.hover, bufopts)

  -- filetype config
  filetype_attach[filetype](client, bufnr)
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
