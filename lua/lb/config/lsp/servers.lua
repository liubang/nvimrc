-- =====================================================================
--
-- lspconfig.lua - 
--
-- Created by liubang on 2021/02/06 00:05
-- Last Modified: 2021/02/06 00:05
--
-- =====================================================================
local c = require('lb.config.lsp.customs')
local lspconfig = require('lspconfig')
local lspconfig_util = require('lspconfig/util')

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

-- ccls
local ccls_init = {cache = {directory = '/tmp/ccls'}}
if jit.os == 'OSX' then
  ccls_init.clang = {
    resourceDir = os.getenv('CLANG_RESOURCEDIR') or '',
    extraArgs = {
      '-isystem',
      os.getenv('CLANG_ISYSTEM') or '',
      '-I',
      os.getenv('CLANG_INCLUDE') or '',
    },
  }
elseif jit.os == 'Linux' then
  -- ccls_init.clang = {extraArgs = {'--gcc-toolchain=/usr/local'}}
end

lspconfig.ccls.setup(c.default({
  cmd = {'ccls'},
  filetypes = {'c', 'cpp'},
  init_options = ccls_init,
  root_dir = lspconfig_util.root_pattern(
    {'.ccls', '.git/', 'compile_commands.json'}),
}))

vim.cmd [[augroup lsp]]
vim.cmd [[  autocmd! ]]
vim.cmd [[  autocmd BufWritePre *.go lua GoOrgImports({}, 1000) ]]
vim.cmd [[augroup END]]

lspconfig.gopls.setup(c.default({
  cmd = {'gopls'},
  init_options = {usePlaceholders = true, completeUnimported = true},
}))

local get_lua_runtime = function()
  local result = {};
  for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
    local lua_path = path .. '/lua/'
    if vim.fn.isdirectory(lua_path) then
      result[lua_path] = true
    end
  end
  -- This loads the `lua` files from nvim into the runtime.
  result[vim.fn.expand('$VIMRUNTIME/lua')] = true
  return result;
end

local sumneko_command = function()
  local lua_ls_path = vim.g.cache_path .. '/lua-language-server'
  local lua_ls_bin = ''
  if jit.os == 'OSX' then
    lua_ls_bin = lua_ls_path .. '/bin/macOS/lua-language-server'
  elseif jit.os == 'Linux' then
    lua_ls_bin = lua_ls_path .. '/bin/Linux/lua-language-server'
  end
  return {
    lua_ls_bin,
    '-E',
    'LANG="zh-cn"',
    string.format('%s/main.lua', lua_ls_path),
  }
end

lspconfig.sumneko_lua.setup(c.default({
  cmd = sumneko_command(),
  filetypes = {'lua'},
  settings = {
    Lua = {
      runtime = {version = 'LuaJIT'},
      completion = {keywordSnippet = 'Disable'},
      diagnostics = {
        enable = true,
        disable = {'trailing-space'},
        globals = {
          'vim',
          'describe',
          'it',
          'before_each',
          'after_each',
          'teardown',
          'pending',
        },
      },
      workspace = {
        library = get_lua_runtime(),
        maxPreload = 1000,
        preloadFileSize = 1000,
      },
    },
  },
}))

-- diagnosticls
lspconfig.diagnosticls.setup(c.default({
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
