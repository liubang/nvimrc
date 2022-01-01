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

--- for cpp
local get_default_driver = function()
  local j = Job:new { command = 'which', args = { 'g++' } }
  local ok, result = pcall(function()
    return vim.trim(j:sync()[1])
  end)
  if ok then
    return result
  end
  return nil
end

local get_gopls_opts = function(server)
  -- https://github.com/ray-x/go.nvim/blob/master/lua/go/lsp.lua
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

local get_diagnostic_opts = function(_)
  return {
    filetypes = { 'lua', 'bzl', 'sh', 'markdown', 'yaml', 'json', 'jsonc' },
    init_options = {
      formatters = {
        buildifier = { command = 'buildifier' },
        stylua = {
          command = 'stylua',
          args = { '-' },
          rootPatterns = { 'stylua.toml' },
          requiredFiles = { 'stylua.toml' },
        },
        shfmt = {
          command = 'shfmt',
          args = { '-filename', '%filepath' },
          rootPatterns = { '.editorconfig' },
        },
        prettier = {
          command = 'prettier',
          args = { '--stdin', '--stdin-filepath', [[%filepath]] },
        },
      },
      formatFiletypes = {
        sh = 'shfmt',
        bzl = 'buildifier',
        lua = 'stylua',
        json = 'prettier',
        jsonc = 'prettier',
        markdown = 'prettier',
        yaml = 'prettier',
      },
    },
  }
end

lsp_installer.on_server_ready(function(server)
  local opts = {}
  if server.name == 'sumneko_lua' then
    opts.settings = {
      Lua = {
        diagnostics = { globals = { 'vim', 'packer_plugins' } },
        workspace = {
          library = {
            [vim.fn.expand '$VIMRUNTIME/lua'] = true,
            [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
        telemetry = { enable = false },
      },
    }
  elseif server.name == 'clangd' then
    local cmd = {
      vim.fn.expand(server.root_dir .. '/clangd_*/bin/clangd'),
      '--background-index',
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
  elseif server.name == 'diagnosticls' then
    opts = get_diagnostic_opts(server)
  end
  server:setup(c.default(opts))
end)
