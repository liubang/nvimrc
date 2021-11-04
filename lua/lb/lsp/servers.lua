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
local util = require 'lspconfig.util'
local my_os_type = os.getenv 'MY_OS_TYPE'

local servers = {
  'texlab',
  'bashls',
  'cmake',
  'dockerls',
  'jsonls',
  'vimls',
  'yamlls',
  'intelephense',
  'pylsp',
}

for _, ls in ipairs(servers) do
  lspconfig[ls].setup(c.default())
end

if my_os_type == 'own' then
  require('nlua.lsp.nvim').setup(
    lspconfig,
    c.default {
      globals = {
        -- Colorbuddy
        'Color',
        'c',
        'Group',
        'g',
        's',
      },
    }
  )

  -- diagnosticls
  lspconfig.diagnosticls.setup(c.default {
    cmd = { 'diagnostic-languageserver', '--stdio' },
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
        prettier = { command = 'prettier', args = { '--stdin', '--stdin-filepath', [[%filepath]] } },
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
  })
end

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

local get_cland_cmd = function()
  local cmd = {
    'clangd',
    '--background-index',
    '--suggest-missing-includes',
    '--clang-tidy',
    '--header-insertion=never',
  }
  local driver = get_default_driver()
  if driver ~= nil then
    table.insert(cmd, string.format('--query-driver=%s', driver))
  end
  return cmd
end

lspconfig.clangd.setup(c.default {
  cmd = get_cland_cmd(),
  -- Required for lsp-status
  init_options = { clangdFileStatus = true },
})

-- ccls
-- local ccls_init = {cache = {directory = '/tmp/ccls'}}
-- if jit.os == 'OSX' then
--   ccls_init.clang = {
--     resourceDir = os.getenv('CLANG_RESOURCEDIR') or '',
--     extraArgs = {
--       '-isystem',
--       os.getenv('CLANG_ISYSTEM') or '',
--       '-I',
--       os.getenv('CLANG_INCLUDE') or '',
--     },
--   }
-- elseif jit.os == 'Linux' then
--   -- ccls_init.clang = {extraArgs = {'--gcc-toolchain=/usr/local'}}
-- end

-- lspconfig.ccls.setup(c.default({
--   cmd = {'ccls'},
--   filetypes = {'c', 'cpp'},
--   init_options = ccls_init,
--   root_dir = lspconfig_util.root_pattern(
--     {'.ccls', '.git/', 'compile_commands.json'}),
-- }))

-- for golang
-- https://github.com/ray-x/go.nvim/blob/master/lua/go/lsp.lua
lspconfig.gopls.setup(c.default {
  cmd = {
    'gopls', -- share the gopls instance if there is one already
    '-remote.debug=:0',
  },
  filetypes = { 'go', 'gomod' },
  flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
  settings = {
    gopls = {
      -- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
      -- flags = {allow_incremental_sync = true, debounce_text_changes = 500},
      -- not supported
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
      -- experimentalDiagnosticsDelay = "500ms",
      diagnosticsDelay = '500ms',
      experimentalWatchedFileDelay = '100ms',
      symbolMatcher = 'fuzzy',
      ['local'] = '',
      gofumpt = false, -- true, -- turn on for new repos, gofmpt is good but also create code turmoils
      buildFlags = { '-tags', 'integration' },
      -- buildFlags = {"-tags", "functional"}
    },
  },
})
