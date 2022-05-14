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

-- for lua
local function get_lua_runtime()
  local result = {}
  for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
    local lua_path = path .. '/lua/'
    if vim.fn.isdirectory(lua_path) then
      result[lua_path] = true
    end
  end
  -- This loads the `lua` files from nvim into the runtime.
  result[vim.fn.expand '$VIMRUNTIME/lua'] = true
  return result
end

require('nvim-lsp-installer').setup {
  -- ensure_installed is not needed as automatic_installation is enabled
  -- then any lsp server you setup by lspconfig is going to get installed automatically!
  -- ensure_installed = { "lua" },
  automatic_installation = true,
  ui = {
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
  cmd = { 'gopls', '-remote.debug=:0' },
  filetypes = { 'go', 'gomod' },
  flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
  settings = {
    gopls = {
      analyses = { unusedparams = true, unreachable = false },
      codelenses = {
        generate = true, -- show the `go generate` lens.
        gc_details = true, --  // Show a code lens toggling the display of gc's choices.
        test = true,
        tidy = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      matcher = 'Fuzzy',
      diagnosticsDelay = '500ms',
      experimentalWatchedFileDelay = '100ms',
      symbolMatcher = 'fuzzy',
      ['local'] = '',
      gofumpt = false, -- true, -- turn on for new repos, gofmpt is good but also create code turmoils
      buildFlags = { '-tags', 'integration' },
    },
  },
})

lspconfig.sumneko_lua.setup(c.default {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      format = { enable = false },
      completion = {
        keywordSnippet = 'Disable',
        showWord = 'Disable',
      },
      diagnostics = { enable = true, globals = { 'vim', 'packer_plugins' } },
      workspace = {
        library = vim.list_extend(get_lua_runtime(), {}),
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})

lspconfig.bashls.setup(c.default())
lspconfig.cmake.setup(c.default())
lspconfig.texlab.setup(c.default())
lspconfig.intelephense.setup(c.default())
