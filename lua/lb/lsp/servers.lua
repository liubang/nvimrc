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

require('mason').setup {
  ui = {
    border = 'single',
    icons = {
      package_installed = ' ',
      package_pending = ' ',
      package_uninstalled = ' ﮊ',
    },
    keymaps = {
      -- Keymap to expand a package
      toggle_package_expand = '<CR>',
      -- Keymap to install the package under the current cursor position
      install_package = 'i',
      -- Keymap to reinstall/update the package under the current cursor position
      update_package = 'u',
      -- Keymap to check for new version for the package under the current cursor position
      check_package_version = 'c',
      -- Keymap to update all installed packages
      update_all_packages = 'U',
      -- Keymap to check which installed packages are outdated
      check_outdated_packages = 'C',
      -- Keymap to uninstall a package
      uninstall_package = 'X',
      -- Keymap to cancel a package installation
      cancel_installation = '<C-c>',
      -- Keymap to apply language filter
      apply_language_filter = '<C-f>',
    },
  },
  max_concurrent_installers = 4,
}

require('mason-lspconfig').setup {
  ensure_installed = {},
  automatic_installation = true,
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

-- clangd
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

-- gopls
lspconfig.gopls.setup(c.default {
  -- share the gopls instance if there is one already
  cmd = { 'gopls', '-remote.debug=:0' },
  filetypes = { 'go', 'gomod', 'gosum', 'gotmpl', 'gohtmltmpl', 'gotexttmpl' },
  message_level = vim.lsp.protocol.MessageType.Error,
  flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
  settings = {
    gopls = {
      -- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
      analyses = {
        unusedparams = true,
        unreachable = true,
        nilness = true,
        useany = true,
        unusedwrite = true,
        ST1003 = true,
        undeclaredname = true,
        fillreturns = true,
        nonewvars = true,
        fieldalignment = false,
        shadow = true,
      },
      codelenses = {
        generate = true, -- show the `go generate` lens.
        gc_details = true, -- Show a code lens toggling the display of gc's choices.
        test = true,
        tidy = true,
        vendor = true,
        regenerate_cgo = true,
        upgrade_dependency = true,
      },
      experimentalUseInvalidMetadata = true,
      hoverKind = 'Structured',
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      matcher = 'Fuzzy',
      diagnosticsDelay = '500ms',
      experimentalWatchedFileDelay = '200ms',
      symbolMatcher = 'fuzzy',
      gofumpt = true, -- true|false, -- turn on for new repos, gofmpt is good but also create code turmoils
      buildFlags = { '-tags', 'integration' },
    },
  },
})

-- for rust
require('rust-tools').setup {
  tools = {
    autoSetHints = true,
    hover_with_actions = true,
    inlay_hints = {
      show_parameter_hints = false,
      parameter_hints_prefix = '',
      other_hints_prefix = '',
    },
  },

  -- all the opts to send to nvim-lspconfig
  server = c.default {
    settings = {
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ['rust-analyzer'] = {
        -- enable clippy on save
        checkOnSave = {
          command = 'clippy',
        },
      },
    },
  },
}

-- phpactor
lspconfig.phpactor.setup(c.default {
  init_options = {
    ['language_server_phpstan.enabled'] = true,
  },
})

-- sumneko_lua
lspconfig.sumneko_lua.setup(c.default(require('lua-dev').setup()))

-- some others use default config
local servers = { 'bashls', 'cmake', 'texlab' }

for _, server in pairs(servers) do
  lspconfig[server].setup(c.default())
end
