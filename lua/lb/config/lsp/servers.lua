-- =====================================================================
--
-- lspconfig.lua - 
--
-- Created by liubang on 2021/02/06 00:05
-- Last Modified: 2021/02/06 00:05
--
-- =====================================================================
local c = require('lb.config.lsp.customs')
local Job = require('plenary.job')
local lspconfig = require('lspconfig')
local my_os_type = os.getenv('MY_OS_TYPE')

if my_os_type == 'own' then
  local servers = {
    'texlab',
    'bashls',
    'cmake',
    'cssls',
    'dockerls',
    'jsonls',
    'vimls',
    'yamlls',
    'intelephense',
  }

  for _, ls in ipairs(servers) do
    lspconfig[ls].setup(c.default())
  end

  require('nlua.lsp.nvim').setup(lspconfig, c.default(
                                   {
      globals = {
        -- Colorbuddy
        'Color',
        'c',
        'Group',
        'g',
        's',
      },
    }))

  -- diagnosticls
  lspconfig.diagnosticls.setup(c.default(
                                 {
      cmd = {'diagnostic-languageserver', '--stdio'},
      filetypes = {'lua', 'bzl', 'sh', 'markdown', 'yaml', 'json', 'jsonc'},
      init_options = {
        formatters = {
          buildifier = {command = 'buildifier'},
          lua_format = {
            command = 'lua-format',
            args = {
              '--column-limit=80',
              '--indent-width=2',
              '--tab-width=2',
              '--continuation-indent-width=2',
              '--align-table-field',
              '--align-args',
              '--align-parameter',
              '--chop-down-table',
              '--chop-down-parameter',
              '--chop-down-kv-table',
              '--extra-sep-at-table-end',
              '--no-keep-simple-function-one-line',
              '--no-break-after-functioncall-lp',
              '--double-quote-to-single-quote',
              '--no-keep-simple-control-block-one-line',
            },
          },
          shfmt = {command = 'shfmt'},
          prettier = {
            command = 'prettier',
            args = {'--stdin', '--stdin-filepath', [[%filepath]]},
          },
        },
        formatFiletypes = {
          sh = 'shfmt',
          bzl = 'buildifier',
          lua = 'lua_format',
          json = 'prettier',
          jsonc = 'prettier',
          markdown = 'prettier',
          yaml = 'prettier',
        },
      },
    }))
end

local get_default_driver = function()
  local j = Job:new({
    command = "which",
    args = {"g++"},
  })

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

lspconfig.clangd.setup(c.default({
  cmd = get_cland_cmd(),
  -- Required for lsp-status
  init_options = {clangdFileStatus = true},
}))

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
lspconfig.gopls.setup(c.default({
  cmd = {'gopls'},
  init_options = {usePlaceholders = true, completeUnimported = true},
}))
