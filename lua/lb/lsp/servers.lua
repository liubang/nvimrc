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
local lsp_installer = require 'nvim-lsp-installer'
local util = require 'lspconfig.util'

--- for cpp
local get_default_driver = function()
  local gcc = Job:new { command = 'which', args = { 'g++' } }
  local llvm = Job:new { command = 'which', args = { 'clang++' } }
  local ok, result = pcall(function()
    local ret = {}
    table.insert(ret, vim.trim(gcc:sync()[1]))
    table.insert(ret, vim.trim(llvm:sync()[1]))
    return ret
  end)
  if ok then
    return table.concat(result, ',')
  end
  return nil
end

local get_gopls_opts = function(server)
  -- https://github.com/ray-x/go.nvim/blob/master/lua/go/gopls.lua
  return {
    cmd = { vim.fn.expand(server.root_dir .. '/gopls'), '-remote.debug=:0' },
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
  }
end

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

lsp_installer.on_server_ready(function(server)
  local opts = {}
  if server.name == 'sumneko_lua' then
    opts.settings = {
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
    }
  elseif server.name == 'clangd' then
    local cmd = {
      vim.fn.expand(server.root_dir .. '/clangd/bin/clangd'),
      '--background-index',
      '-j=4',
      '--suggest-missing-includes',
      '--clang-tidy',
      '--header-insertion=never',
    }
    local driver = get_default_driver()
    if driver ~= nil then
      table.insert(cmd, string.format('--query-driver=%s', driver))
    end
    opts.cmd = cmd
  elseif server.name == 'gopls' then
    opts = get_gopls_opts(server)
  elseif server.name == 'zeta_note' then
    opts.cmd = { vim.fn.expand(server.root_dir .. '/zeta-note') }
    opts.filetypes = { 'markdown', 'md' }
    opts.root_dir = util.root_pattern { '.zeta.toml', '.git/' }
  end
  server:setup(c.default(opts))
end)
