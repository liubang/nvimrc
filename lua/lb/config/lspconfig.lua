-- =====================================================================
--
-- lspconfig.lua - 
--
-- Created by liubang on 2021/01/31 18:07
-- Last Modified: 2021/01/31 18:07
--
-- =====================================================================
local lspconfig = require('lspconfig')
local lspconfig_util = require('lspconfig/util')
local nvim_compe = require('compe')

vim.g.vsnip_snippet_dir = vim.g.snip_path

nvim_compe.setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'always',
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  allow_prefix_unmatch = false,
  source = {
    path = true,
    buffer = true,
    vsnip = true,
    nvim_lsp = true,
    nvim_lua = true,
  },
}

-- golang organize imports
function go_org_imports(options, timeout_ms)
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, 't', true } }
  local params = vim.lsp.util.make_range_params()
  params.context = context
  local results = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  if not results then return end
  result = results[1].result
  if not result then return end
  edit = result[1].edit
  vim.lsp.util.apply_workspace_edit(edit)
end

vim.cmd[[augroup lsp]]
vim.cmd[[  autocmd! ]]
vim.cmd[[  autocmd BufWritePre *.go lua go_org_imports({}, 1000) ]]
vim.cmd[[augroup END]]

-- define commands
vim.schedule(function()
  vim.cmd [[command! -nargs=0 Format :lua vim.lsp.buf.formatting()]]
end)

local custom_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', '<Leader>gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<Leader>gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<Leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Leader>hh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Leader>ee', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  if client.resolved_capabilities.document_formatting then 
    buf_set_keymap("n", "<Leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts) 
  end
  if client.resolved_capabilities.document_range_formatting then 
    buf_set_keymap("v", "<Leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts) 
  end
end

local servers = {
  'bashls',
  'cmake',
  'cssls',
  'dockerls',
  'jsonls',
  'vimls',
  'yamlls'
}

for _, ls in ipairs(servers) do 
  lspconfig[ls].setup {
    on_attach = custom_attach
  }
end

-- ccls
local ccls_init = {cache = {directory = '/tmp/ccls'}}
if jit.os == 'OSX' then
  ccls_init.clang = {
    resourceDir = os.getenv('CLANG_RESOURCEDIR') or '',
    extraArgs = {'-isystem', os.getenv('CLANG_ISYSTEM') or '', '-I', os.getenv('CLANG_INCLUDE') or ''},
  }
elseif jit.os == 'Linux' then
  ccls_init.clang = {extraArgs = {'--gcc-toolchain=/usr'}}
end
lspconfig.ccls.setup {
  on_attach = custom_attach,  
  cmd = {'ccls'},
  filetypes = {'c', 'cpp'},
  init_options = ccls_init,
  root_dir = lspconfig_util.root_pattern({'.ccls', '.git/', 'compile_commands.json'})
}

lspconfig.gopls.setup {
  on_attach = custom_attach,
  cmd = {
    'gopls',
  }, 
  capabilities ={
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true
        }
      }
    }
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
  }
}

local get_lua_runtime = function()
  local result = {};
  for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
    local lua_path = path .. "/lua/"
    if vim.fn.isdirectory(lua_path) then
      result[lua_path] = true
    end
  end
  -- This loads the `lua` files from nvim into the runtime.
  result[vim.fn.expand("$VIMRUNTIME/lua")] = true
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
    string.format(
      '%s/main.lua',
      lua_ls_path
    )
  }
end

lspconfig.sumneko_lua.setup {
  cmd = sumneko_command(),
  on_attach = custom_attach,
  filetypes = {"lua"},
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      completion = {
        keywordSnippet = "Disable",
      },
      diagnostics = {
        enable = true,
        disable = {
          'trailing-space',
        },
        globals = {
          'vim',
          'describe', 'it', 'before_each', 'after_each', 'teardown', 'pending'
        }
      },
      workspace = {
        library = get_lua_runtime(),
        maxPreload = 1000,
        preloadFileSize = 1000,
      },
    },
  },
}
