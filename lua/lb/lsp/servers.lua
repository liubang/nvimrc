-- =====================================================================
--
-- lspconfig.lua -
--
-- Created by liubang on 2021/02/06 00:05
-- Last Modified: 2021/02/06 00:05
--
-- =====================================================================
local c = require 'lb.lsp.customs'
local Job = require 'plenary.job'
local lspconfig = require 'lspconfig'

require('nvim-lsp-installer').setup {
  automatic_installation = true,
  ui = {
    check_outdated_servers_on_open = true,
    icons = {
      server_installed = '',
      server_pending = '',
      server_uninstalled = 'ﮊ',
    },
    keymaps = {
      toggle_server_expand = '<CR>',
      install_server = 'i',
      update_server = 'u',
      check_server_version = 'c',
      update_all_servers = 'U',
      check_outdated_servers = 'C',
      uninstall_server = 'X',
    },
  },
  max_concurrent_installers = 20,
}

--- for cpp
local get_default_driver = function()
  local gcc = Job:new { command = 'which', args = { 'g++' } }
  local llvm = Job:new { command = 'which', args = { 'clang++' } }
  local _, result = pcall(function()
    local gcct = gcc:sync()
    local llvmt = llvm:sync()
    if #gcct > 0 then
      return vim.trim(gcct[1])
    end
    if #llvmt > 0 then
      return vim.trim(llvmt[1])
    end
    return nil
  end)
  return result
end

lspconfig.clangd.setup(c.default {
  cmd = {
    'clangd',
    '--background-index',
    '-j=4',
    '--suggest-missing-includes',
    '--clang-tidy',
    '--header-insertion=never',
    '--query-driver=' .. get_default_driver(),
  },
})

lspconfig.gopls.setup(c.default {
  -- share the gopls instance if there is one already
  cmd = { 'gopls', '-remote.debug=:0' },
  filetypes = { 'go', 'gomod', 'gosum', 'gotmpl', 'gohtmltmpl', 'gotexttmpl' },
  flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        unreachable = true,
        shadow = true,
      },
      codelenses = {
        generate = true,
        gc_details = true,
        test = true,
        tidy = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      gofumpt = true,
      ['local'] = '',
    },
  },
})

lspconfig.sumneko_lua.setup(c.default(require('lua-dev').setup()))

local servers = { 'bashls', 'cmake', 'texlab', 'intelephense', 'rust_analyzer' }

for _, server in pairs(servers) do
  lspconfig[server].setup(c.default())
end
