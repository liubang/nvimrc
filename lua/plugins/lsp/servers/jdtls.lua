--=====================================================================
--
-- jdtls.lua -
--
-- Created by liubang on 2023/02/18 02:27
-- Last Modified: 2023/02/18 02:27
--
--=====================================================================

local M = {}
local c = require "plugins.lsp.customs"

local real_setup = function()
  local settings = {
    ["java.format.settings.profile"] = "GoogleStyle",
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
      },
      filteredTypes = {
        "com.sun.*",
        "io.micrometer.shaded.*",
        "java.awt.*",
        "jdk.*",
        "sun.*",
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
      },
      configuration = {
        runtimes = {
          {
            name = "JavaSE-17",
            path = "/opt/app/java",
          },
        },
      },
    },
  }

  local jdtls = require "jdtls"
  local extendedClientCapabilities = jdtls.extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

  jdtls.setup.add_commands()
  jdtls.start_or_attach(c.default {
    cmd = { "jdtls" },
    flags = {
      allow_incremental_sync = true,
    },
    single_file_support = true,
    on_init = function(client, _)
      client.notify("workspace/didChangeConfiguration", { settings = settings })
    end,
    init_options = {
      extendedClientCapabilities = extendedClientCapabilities,
    },
  })
end

function M.setup()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "java", "pom" },
    callback = function(_)
      real_setup()
    end,
  })
end

return M
