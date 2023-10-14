--=====================================================================
--
-- servers.lua -
--
-- Created by liubang on 2023/05/12 14:51
-- Last Modified: 2023/05/12 14:51
--
--=====================================================================

local c = require "plugins.lsp.customs"
local lspconfig = require "lspconfig"
local Job = require "plenary.job"
local is_mac = vim.loop.os_uname().version:match "Darwin"

-- {{{ clangd
local function get_binary_path(bin)
  local j = Job:new { command = "which", args = { bin } }
  local _, result = pcall(function()
    local out = j:sync()
    if #out > 0 then
      return vim.trim(out[1])
    end
    return nil
  end)
  return result
end

local function get_default_drivers(binaries)
  local path_list = {}
  for _, binary in ipairs(binaries) do
    local path = get_binary_path(binary)
    if path then
      table.insert(path_list, path)
    end
  end
  return table.concat(path_list, ",")
end

local luv = require "luv"
local cpu = luv.available_parallelism()

local function get_clangd_cmd()
  local cmd = {
    "clangd",
    "--background-index",
    "-j=" .. (cpu / 2),
    "--pch-storage=memory",
    "--function-arg-placeholders",
    "--clang-tidy",
    "--header-insertion=never",
    "--completion-style=detailed",
    "--query-driver=" .. get_default_drivers { "clang++", "clang", "gcc", "g++" },
    "--enable-config",
    "--fallback-style=google",
    "--limit-references=500",
    "--limit-results=50",
    "--log=error",
  }
  if not is_mac then
    table.insert(cmd, "--malloc-trim")
  end
  return cmd
end

lspconfig.clangd.setup(c.default {
  cmd = get_clangd_cmd(),
  -- disable proto type
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  init_options = {
    clangdFileStatus = true,
  },
})
-- }}}

-- {{{ gopls
local get_current_gomod = function()
  local file = io.open("go.mod", "r")
  if file == nil then
    return nil
  end

  local first_line = file:read()
  local mod_name = first_line:gsub("module ", "")
  file:close()
  return mod_name
end

lspconfig.gopls.setup(c.default {
  -- share the gopls instance if there is one already
  cmd = { "gopls", "-remote.debug=:0" },
  filetypes = { "go", "gomod", "gosum", "gotmpl", "gohtmltmpl", "gotexttmpl" },
  message_level = vim.lsp.protocol.MessageType.Error,
  flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
  settings = {
    gopls = {
      -- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
      analyses = {
        asmdecl = true, -- report mismatches between assembly files and Go declarations
        assign = true, -- check for useless assignments
        atomic = true, -- check for common mistakes using the sync/atomic package
        atomicalign = true, -- check for non-64-bits-aligned arguments to sync/atomic functions
        bools = true,
        buildtag = true,
        cgocall = true,
        composites = true,
        copylocks = true,
        deepequalerrors = true,
        embed = true,
        errorsas = true,
        fieldalignment = true,
        httpresponse = true,
        ifaceassert = true,
        infertypeargs = true,
        loopclosure = true,
        lostcancel = true,
        nilfunc = true,
        nilness = true,
        printf = true,
        shadow = true,
        shift = true,
        simplifycompositelit = true,
        simplifyrange = true,
        simplifyslice = true,
        sortslice = true,
        stdmethods = true,
        stringintconv = true,
        structtag = true,
        testinggoroutine = true,
        tests = true,
        timeformat = true,
        unmarshal = true,
        unreachable = true,
        unsafeptr = true,
        unusedparams = true,
        unusedresult = true,
        unusedwrite = true,
        useany = true,
        fillreturns = true,
        nonewvars = true,
        noresultvalues = true,
        undeclaredname = true,
        unusedvariable = true,
        fillstruct = true,
        stubmethods = true,
      },
      codelenses = {
        generate = true, -- show the `go generate` lens.
        gc_details = true, -- Show a code lens toggling the display of gc's choices.
        test = true,
        tidy = true,
        regenerate_cgo = true,
        run_vulncheck_exp = true,
        upgrade_dependency = true,
      },
      directoryFilters = {
        "-**/node_modules",
        "-/tmp",
      },
      ["local"] = get_current_gomod(),
      semanticTokens = true,
      usePlaceholders = true,
      completeUnimported = true,
      completionDocumentation = true,
      staticcheck = true,
      gofumpt = true,
      linksInHover = true,
      buildFlags = { "-tags", "integration" },
    },
  },
})
-- }}}

-- {{{ rust
require("rust-tools").setup {
  tools = {
    -- how to execute terminal commands
    -- options right now: termopen / quickfix
    executor = require("rust-tools/executors").termopen,

    -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
    reload_workspace_from_cargo_toml = true,

    inlay_hints = {
      auto = true,
      only_current_line = true,
      show_parameter_hints = false,

      -- prefix for parameter hints
      -- default: "<-"
      parameter_hints_prefix = "<- ",

      -- prefix for all the other hints (type, chaining)
      -- default: "=>"
      other_hints_prefix = "=> ",

      -- whether to align to the length of the longest line in the file
      max_len_align = false,

      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,

      -- whether to align to the extreme right or not
      right_align = false,

      -- padding from the right if right_align is true
      right_align_padding = 7,

      -- The color of the hints
      highlight = "Comment",
    },
  },

  crate_graph = {
    -- Backend used for displaying the graph
    -- see: https://graphviz.org/docs/outputs/
    -- default: x11
    backend = "x11",
    -- where to store the output, nil for no output stored (relative
    -- path from pwd)
    -- default: nil
    output = nil,
    -- true for all crates.io and external crates, false only the local
    -- crates
    -- default: true
    full = true,

    -- List of backends found on: https://graphviz.org/docs/outputs/
    -- Is used for input validation and autocompletion
    -- Last updated: 2021-08-26
    enabled_graphviz_backends = {
      "bmp",
      "cgimage",
      "canon",
      "dot",
      "gv",
      "xdot",
      "xdot1.2",
      "xdot1.4",
      "eps",
      "exr",
      "fig",
      "gd",
      "gd2",
      "gif",
      "gtk",
      "ico",
      "cmap",
      "ismap",
      "imap",
      "cmapx",
      "imap_np",
      "cmapx_np",
      "jpg",
      "jpeg",
      "jpe",
      "jp2",
      "json",
      "json0",
      "dot_json",
      "xdot_json",
      "pdf",
      "pic",
      "pct",
      "pict",
      "plain",
      "plain-ext",
      "png",
      "pov",
      "ps",
      "ps2",
      "psd",
      "sgi",
      "svg",
      "svgz",
      "tga",
      "tiff",
      "tif",
      "tk",
      "vml",
      "vmlz",
      "wbmp",
      "webp",
      "xlib",
      "x11",
    },
  },

  -- all the opts to send to nvim-lspconfig
  server = c.default {
    -- standalone file support
    -- setting it to false may improve startup time
    standalone = true,

    settings = {
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy on save
        -- checkOnSave = {
        --   command = 'clippy',
        -- },
      },
    },
  },
}
-- }}}

-- {{{pyright
lspconfig.pyright.setup(c.default {
  single_file_support = true,
  settings = {
    pyright = {
      disableLanguageServices = false,
      disableOrganizeImports = false,
    },
    python = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        typeCheckingMode = "basic",
        useLibraryCodeForTypes = true,
      },
    },
  },
})
-- }}}

-- {{{ jsonls
lspconfig.jsonls.setup(c.default {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
      format = { enable = true },
    },
  },
})
-- }}}

-- {{{ lua_ls
lspconfig.lua_ls.setup(c.default {
  settings = {
    Lua = {
      hint = {
        arrayIndex = "Disable",
        enable = true,
        setType = true,
      },
      workspace = {
        ignoreDir = "tmp/",
        useGitIgnore = false,
        maxPreload = 100000000,
        preloadFileSize = 500000,
        checkThirdParty = false,
      },
      completion = { callSnippet = "Replace" },
      format = { enable = false },
    },
  },
})
-- }}}

-- {{{ latex
local forwardSearch = {}
if not is_mac then
  forwardSearch = {
    executable = "zathura",
    args = { "--synctex-forward", "%l:1:%f", "%p" },
  }
else
  forwardSearch = {
    executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
    args = { "%l", "%p", "%f" },
  }
end
lspconfig.texlab.setup(c.default {
  flags = { allow_incremental_sync = false },
  settings = {
    texlab = {
      rootDirectory = nil,
      build = {
        executable = "latexmk",
        args = {
          "-xelatex",
          "-file-line-error",
          "-halt-on-error",
          "-interaction=nonstopmode",
          "-synctex=1",
          "-shell-escape",
          -- "-pv",
          "-f",
          "-outdir=build",
          "%f",
        },
        onSave = true,
        forwardSearchAfter = false,
      },
      auxDirectory = "build",
      diagnosticsDelay = 50,
      forwardSearch = forwardSearch,
      chktex = { onOpenAndSave = true, onEdit = false },
      formatterLineLength = 120,
      -- latexFormatter = "latexindent",
      -- latexindent = {
      --   ["local"] = nil, -- local is a reserved keyword
      --   modifyLineBreaks = false,
      -- },
      -- bibtexFormatter = "texlab",
    },
  },
})
-- }}}

-- {{{ typescript
require("typescript").setup {
  server = c.default {
    settings = {
      completions = {
        completeFunctionCalls = true,
      },
    },
  },
}
-- }}}

-- {{{ vue
lspconfig.vuels.setup(c.default {
  settings = {
    vetur = {
      completion = {
        autoImport = true,
        useScaffoldSnippets = true,
      },
      format = {
        defaultFormatter = {
          html = "none",
          js = "prettier",
          ts = "prettier",
        },
      },
      validation = {
        template = true,
        script = true,
        style = true,
        templateProps = true,
        interpolation = true,
      },
      experimental = {
        templateInterpolationService = true,
      },
    },
  },
})
-- }}}

-- {{{ yaml
lspconfig.yamlls.setup(c.default {
  settings = {
    yaml = {
      format = { enable = true, singleQuote = true },
      validate = true,
      hover = true,
      completion = true,
      schemas = require("schemastore").yaml.schemas(),
    },
  },
})
-- }}}

-- {{{ others
for _, server in ipairs {
  "thriftls",
  "taplo", -- for toml
  "html",
  "cssls",
  "emmet_ls", -- emmet YYDS!
  "bashls",
  "cmake",
  "vimls",
  "lemminx", -- for xml
  "intelephense",
  "nginx_language_server",
} do
  lspconfig[server].setup(c.default())
end
-- }}}

-- vim: fdm=marker fdl=0
