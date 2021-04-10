-- =====================================================================
--
-- lspconfig.lua - 
--
-- Created by liubang on 2021/02/06 00:05
-- Last Modified: 2021/02/06 00:05
--
-- =====================================================================
local lspconfig = require('lspconfig')
local lspconfig_util = require('lspconfig/util')
local lspprotocol = require('vim.lsp.protocol')

lspprotocol.CompletionItemKind = {
  ' Text', -- = 1
  'ƒ Method', -- = 2;
  ' Function', -- = 3;
  ' Constructor', -- = 4;
  '綠Field', -- = 5;
  ' Variable', -- = 6;
  ' Class', -- = 7;
  '禍Interface', -- = 8;
  ' Module', -- = 9;
  ' Property', -- = 10;
  ' Unit', -- = 11;
  ' Value', -- = 12;
  ' Enum', -- = 13;
  ' Keyword', -- = 14;
  ' Snippet', -- = 15;
  ' Color', -- = 16;
  ' File', -- = 17;
  '  Reference', -- = 18;
  ' Folder', -- = 19;
  ' EnumMember', -- = 20;
  ' Constant', -- = 21;
  ' Struct', -- = 22;
  '鬒Event', -- = 23;
  '洛Operator', -- = 24;
  '  TypeParameter', -- = 25;
}

-- define commands
vim.schedule(function()
  vim.cmd [[command! -nargs=0 Format :lua vim.lsp.buf.formatting()]]
end)

-- custom attach function
local opts = {noremap = true, silent = true}
local function buf_set_keymap(...)
  vim.api.nvim_buf_set_keymap(bufnr, ...)
end
-- LuaFormatter off
local custom_attach = function(client, bufnr)
  buf_set_keymap('n', '<Leader>gD', ':lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<Leader>gd', ':lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>gi', ':lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<Leader>gr', ':lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<Leader>rn', ':lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Leader>hh', ':lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Leader>ee', ':lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap('n', '<Leader>fm', ':lua vim.lsp.buf.formatting()<CR>', opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap('v', '<Leader>fm', ':lua vim.lsp.buf.formatting()<CR>', opts)
  end
end
-- LuaFormatter on

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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

for _, ls in ipairs(servers) do
  lspconfig[ls].setup {capabilities = capabilities, on_attach = custom_attach}
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
lspconfig.ccls.setup {
  on_attach = custom_attach,
  cmd = {'ccls'},
  filetypes = {'c', 'cpp'},
  init_options = ccls_init,
  capabilities = capabilities,
  root_dir = lspconfig_util.root_pattern(
    {'.ccls', '.git/', 'compile_commands.json'}),
}

-- golang organize imports
function go_org_imports(options, timeout_ms)
  local context = {source = {organizeImports = true}}
  vim.validate {context = {context, 't', true}}
  local params = vim.lsp.util.make_range_params()
  params.context = context
  local results = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params,
                                           timeout_ms)
  if not results or #results == 0 then
    --- always call formatting
    vim.lsp.buf.formatting()
    return
  end
  result = results[1].result
  if not result or #result == 0 then
    --- always call formatting
    vim.lsp.buf.formatting()
    return
  end
  edit = result[1].edit
  vim.lsp.util.apply_workspace_edit(edit)
  vim.lsp.buf.formatting()
end

vim.cmd [[augroup lsp]]
vim.cmd [[  autocmd! ]]
vim.cmd [[  autocmd BufWritePre *.go lua go_org_imports({}, 1000) ]]
vim.cmd [[augroup END]]

lspconfig.gopls.setup {
  on_attach = custom_attach,
  cmd = {'gopls'},
  capabilities = capabilities,
  init_options = {usePlaceholders = true, completeUnimported = true},
}

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

lspconfig.sumneko_lua.setup {
  cmd = sumneko_command(),
  on_attach = custom_attach,
  capabilities = capabilities,
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
}

-- diagnosticls
lspconfig.diagnosticls.setup {
  on_attach = custom_attach,
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
}
