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
local sysname = vim.loop.os_uname().sysname

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

-- for golang
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

-- for java
local function get_jdtls_config()
  if sysname:match 'Linux' then
    return util.path.join(vim.fn.stdpath 'data', '/lsp_servers/jdtls/config_linux')
  elseif sysname:match 'Darwin' then
    return util.path.join(vim.fn.stdpath 'data', '/lsp_servers/jdtls/config_mac')
  elseif sysname:match 'Windows' then
    return util.path.join(vim.fn.stdpath 'data', '/lsp_servers/jdtls/config_win')
  end
  return util.path.join(vim.fn.stdpath 'data', '/lsp_servers/jdtls/config_linux')
end

local function get_jdtls_options(server)
  local opts = {
    name = 'jdtls',
    cmd = {
      'java',
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xms1g',
      '-Xmx2G',
      '--add-modules=ALL-SYSTEM',
      '--add-opens',
      'java.base/java.util=ALL-UNNAMED',
      '--add-opens',
      'java.base/java.lang=ALL-UNNAMED',
      '-javaagent:' .. vim.fn.stdpath 'data' .. '/lsp_servers/jdtls/lombok.jar',
      '-jar',
      vim.fn.glob(
        vim.fn.stdpath 'data' .. '/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'
      ),
      '-configuration',
      get_jdtls_config(),
      '-data',
      os.getenv 'HOME' .. '/.cache/jdtls-workspace/' .. vim.fn.fnamemodify(
        vim.fn.getcwd(),
        ':p:h:t'
      ),
    },
    settings = {
      java = {
        eclipse = {
          downloadSources = true,
        },
        maven = {
          downloadSources = true,
          updateSnapshots = true,
        },
        progressReports = { enabled = true },
        signatureHelp = { enabled = true },
        configuration = {
          maven = {
            userSettings = os.getenv 'HOME' .. '/.m2/settings.xml',
          },
        },
      },
    },
  }
  local capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )
  local extra_capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
        },
      },
      codeAction = {
        codeActionLiteralSupport = {
          codeActionKind = {
            valueSet = {
              'source.generate.toString',
              'source.generate.hashCodeEquals',
              'source.organizeImports',
            },
          },
        },
      },
    },
  }
  opts.capabilities = vim.tbl_deep_extend('keep', capabilities, extra_capabilities)
  opts.init_options = {
    extendedClientCapabilities = require('jdtls').extendedClientCapabilities,
  }
  return opts
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
  elseif server.name == 'jdtls' then
    opts = get_jdtls_options(server)
  end
  server:setup(c.default(opts))
end)
