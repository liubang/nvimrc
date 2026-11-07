local function load_server(name)
  return dofile(vim.fn.getcwd() .. "/lua/plugins/lsp/servers/" .. name .. ".lua")
end

describe("LSP defaults regressions", function()
  local calls
  local captured_configs
  local defaults
  local enabled_servers
  local original_config
  local original_enable
  local original_on_attach
  local upstream_configs

  before_each(function()
    package.loaded["plugins.lsp.defaults"] = nil
    defaults = require("plugins.lsp.defaults")
    original_config = vim.lsp.config
    original_enable = vim.lsp.enable
    original_on_attach = defaults.on_attach
    calls = {}
    captured_configs = {}
    enabled_servers = {}
    upstream_configs = {}

    vim.lsp.config = setmetatable({}, {
      __index = function(_, server)
        return upstream_configs[server]
      end,
      __call = function(_, server, opts)
        captured_configs[server] = opts
      end,
    })
    vim.lsp.enable = function(server)
      enabled_servers[server] = true
    end
    defaults.on_attach = function(_, bufnr)
      table.insert(calls, "common:" .. bufnr)
    end
  end)

  after_each(function()
    defaults.on_attach = original_on_attach
    vim.lsp.config = original_config
    vim.lsp.enable = original_enable
    package.loaded["plugins.lsp.defaults"] = nil
  end)

  it("runs upstream, common, and server on_attach callbacks in order", function()
    local client = {}
    upstream_configs.demo = {
      on_attach = function(received_client, bufnr)
        assert.are.equal(client, received_client)
        table.insert(calls, "upstream:" .. bufnr)
      end,
    }

    defaults.enable("demo", {
      on_attach = function(received_client, bufnr)
        assert.are.equal(client, received_client)
        table.insert(calls, "server:" .. bufnr)
      end,
    })

    assert.is_true(enabled_servers.demo)
    captured_configs.demo.on_attach(client, 7)
    assert.are.same({ "upstream:7", "common:7", "server:7" }, calls)
  end)

  it("handles nil upstream and server on_attach callbacks", function()
    upstream_configs.upstream_only = {
      on_attach = function()
        table.insert(calls, "upstream")
      end,
    }
    defaults.enable("without_callbacks")
    defaults.enable("upstream_only")
    defaults.enable("server_only", {
      on_attach = function()
        table.insert(calls, "server")
      end,
    })

    captured_configs.without_callbacks.on_attach({}, 1)
    captured_configs.upstream_only.on_attach({}, 2)
    captured_configs.server_only.on_attach({}, 3)

    assert.are.same({ "common:1", "upstream", "common:2", "common:3", "server" }, calls)
  end)
end)

describe("LSP server settings regressions", function()
  it("uses current basedpyright ignore and organize-imports keys", function()
    local basedpyright = load_server("basedpyright").settings.basedpyright

    assert.are.same({ "**/*.pyi" }, basedpyright.analysis.ignore)
    assert.is_nil(basedpyright.analysis.ignorePatterns)
    assert.is_true(basedpyright.disableOrganizeImports)
    assert.is_nil(basedpyright.analysis.disableOrganizeImports)
  end)

  it("removes obsolete gopls keys and supports go.work files", function()
    local config = load_server("gopls")
    local gopls = config.settings.gopls

    assert.is_true(vim.tbl_contains(config.filetypes, "gowork"))
    assert.is_nil(gopls.analyses.useany)
    assert.is_nil(gopls.codelenses.gc_details)
    assert.is_nil(gopls.codelenses.run_vulncheck_exp)
    assert.is_nil(gopls.completeUnimported)
    assert.is_nil(gopls.completionDocumentation)
  end)

  it("enables clangd for doxygen C and C++ buffers", function()
    local config = load_server("clangd")

    assert.are.same({ "c", "c.doxygen", "cpp", "cpp.doxygen", "objc", "objcpp", "cuda" }, config.filetypes)
  end)
end)

describe("jdtls regressions", function()
  local java_config
  local jutils
  local original_java_config
  local original_maven_settings
  local original_runtimes
  local tempdirs

  before_each(function()
    original_java_config = package.loaded["plugins.java.config"]
    package.loaded["plugins.java.config"] = nil
    jutils = require("plugins.java.utils")
    original_maven_settings = jutils.maven_settings
    original_runtimes = jutils.runtimes
    jutils.maven_settings = function()
      return ""
    end
    jutils.runtimes = function()
      return {}
    end
    java_config = require("plugins.java.config")
    tempdirs = {}
  end)

  after_each(function()
    jutils.maven_settings = original_maven_settings
    jutils.runtimes = original_runtimes
    package.loaded["plugins.java.config"] = original_java_config
    for _, dir in ipairs(tempdirs) do
      vim.fn.delete(dir, "rf")
    end
  end)

  local function make_roots()
    local base = vim.fn.tempname()
    table.insert(tempdirs, base)
    local roots = {
      with_formatter = base .. "/with_formatter",
      without_formatter = base .. "/without_formatter",
      other_formatter = base .. "/other_formatter",
    }
    for _, root in pairs(roots) do
      vim.fn.mkdir(root, "p")
    end
    vim.fn.writefile({ "<profiles />" }, roots.with_formatter .. "/eclipse-formatter.xml")
    vim.fn.writefile({ "<profiles />" }, roots.other_formatter .. "/eclipse-formatter.xml")
    return roots
  end

  local function formatter_at(root)
    return {
      url = root .. "/eclipse-formatter.xml",
      profile = "Eclipse",
    }
  end

  it("uses current jdtls keys", function()
    local java = java_config.jdtls_config().settings.java

    assert.is_true(java.codeGeneration.hashCodeEquals.useInstanceof)
    assert.is_nil(java.codeGeneration.hashCodeEquals.useInstanceOf)
    assert.are.equal("none", java.implementationCodeLens)
    assert.is_nil(java.implementationsCodeLens)
    assert.is_nil(java.codeLens)
    assert.is_nil(java.semanticHighlighting)
    assert.are.equal("fernflowerContentProvider", java.contentProvider.preferred)
  end)

  it("resolves formatter settings per root before initialization without sharing state", function()
    local roots = make_roots()
    local config = java_config.jdtls_config()
    local first = { root_dir = roots.with_formatter, settings = config.settings }
    local second = { root_dir = roots.without_formatter, settings = config.settings }
    local third = { root_dir = roots.other_formatter, settings = config.settings }

    assert.is_function(config.before_init)
    assert.is_nil(config.settings.java.format.settings)
    config.before_init({}, first)
    config.before_init({}, second)
    config.before_init({}, third)

    assert.are.same(formatter_at(roots.with_formatter), first.settings.java.format.settings)
    assert.are.same({}, second.settings.java.format.settings)
    assert.are.same(formatter_at(roots.other_formatter), third.settings.java.format.settings)
    assert.is_true(first.settings.java.format.enabled)
    assert.is_nil(config.settings.java.format.settings)
  end)

  it("keeps the no-argument fmt_config cwd fallback", function()
    local roots = make_roots()
    local previous_cwd = vim.uv.cwd()
    local resolved_cwd
    local ok, result = pcall(function()
      vim.cmd("cd " .. vim.fn.fnameescape(roots.with_formatter))
      resolved_cwd = vim.uv.cwd()
      return jutils.fmt_config()
    end)
    vim.cmd("cd " .. vim.fn.fnameescape(previous_cwd))

    assert.is_true(ok, tostring(result))
    assert.are.same(formatter_at(resolved_cwd), result)
    assert.are.same({}, jutils.fmt_config(roots.without_formatter))
  end)
end)
