-- =====================================================================
--
-- lspconfig.lua - 
--
-- Created by liubang on 2021/02/06 00:05
-- Last Modified: 2021/02/06 00:05
--
-- =====================================================================
local c = require('lb.lsp.customs')
local Job = require('plenary.job')
local lspconfig = require('lspconfig')
local util = require('lspconfig.util')
local my_os_type = os.getenv('MY_OS_TYPE')

local servers = {
  'texlab',
  'bashls',
  'cmake',
  'dockerls',
  'jsonls',
  'vimls',
  'yamlls',
  'intelephense',
}

for _, ls in ipairs(servers) do
  lspconfig[ls].setup(c.default())
end

if my_os_type == 'own' then
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
  lspconfig.diagnosticls.setup(c.default({
    cmd = {'diagnostic-languageserver', '--stdio'},
    filetypes = {'lua', 'bzl', 'sh', 'markdown', 'yaml', 'json', 'jsonc'},
    init_options = {
      formatters = {
        buildifier = {command = 'buildifier'},
        stylua = {command = 'stylua'},
        shfmt = {command = 'shfmt'},
        prettier = {command = 'prettier', args = {'--stdin', '--stdin-filepath', [[%filepath]]}},
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
  }))
end

--- for cpp
local get_default_driver = function()
  local j = Job:new({command = 'which', args = {'g++'}})

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

-- for java
lspconfig.jdtls.setup(c.default({
  cmd = {
    vim.g.scripts_path .. '/java-lsp.sh',
    util.root_pattern('pom.xml', 'gradlew')(vim.fn.expand('%:p')),
  },
  flags = {allow_incremental_sync = true},
  init_options = {
    extendedClientCapabilities = {
      progressReportProvider = true,
      classFileContentsSupport = true,
      generateToStringPromptSupport = true,
      hashCodeEqualsPromptSupport = true,
      advancedExtractRefactoringSupport = true,
      advancedOrganizeImportsSupport = true,
      resolveAdditionalTextEditsSupport = true,
      generateConstructorsPromptSupport = true,
      generateDelegateMethodsPromptSupport = true,
      moveRefactoringSupport = true,
      inferSelectionSupport = {'extractMethod', 'extractVariable', 'extractConstant'},
    },
  },
  capabilities = {
    workspace = {configuration = true},
    textDocument = {completion = {completionItem = {snippetSupport = true}}},
  },
  settings = {
    java = {
      signatureHelp = {enabled = true},
      contentProvider = {preferred = 'fernflower'},
      errors = {incompleteClasspath = {severity = 'warning'}},
      saveActions = {organizeImports = true},
      maven = {downloadSources = true, updateSnapshots = true},
      format = {enabled = true},
      configuration = {
        checkProjectSettingsExclusions = true,
        runtimes = {{default = true, name = 'JavaSE-16', path = os.getenv('JAVA_HOME')}},
      },
      completion = {
        favoriteStaticMembers = {
          'org.junit.Assert.*',
          'org.junit.Assume.*',
          'org.junit.jupiter.api.Assertions.*',
          'org.junit.jupiter.api.Assumptions.*',
          'org.junit.jupiter.api.DynamicContainer.*',
          'org.junit.jupiter.api.DynamicTest.*',
        },
        importOrder = {'java', 'javax', 'com', 'org'},
        maxResults = 0.0,
        enabled = true,
        overwrite = true,
        guessMethodArguments = true,
      },
      sources = {organizeImports = {starThreshold = 9999, staticStarThreshold = 9999}},
      import = {
        gradle = {enabled = true},
        maven = {enabled = true},
        exclusions = {
          '**/node_modules/**',
          '**/.metadata/**',
          '**/archetype-resources/**',
          '**/META-INF/maven/**',
          '/**/test/**',
        },
      },
      codeGeneration = {
        toString = {
          template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
        },
        hashCodeEquals = {useJava7Objects = false, useInstanceof = false},
        useBlocks = false,
        generateComments = false,
        skipNullValues = false,
        listArrayContents = true,
        limitElements = 0.0,
      },
    },
  },
}))
