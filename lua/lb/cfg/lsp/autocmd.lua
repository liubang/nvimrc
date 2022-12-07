--=====================================================================
--
-- autocmd.lua -
--
-- Created by liubang on 2022/10/18 00:38
-- Last Modified: 2022/12/07 22:35
--
--=====================================================================

local lsp_events_group = vim.api.nvim_create_augroup("LSP_EVENTS", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = lsp_events_group,
  pattern = "go.mod",
  callback = function(_) -- args
    require("lb.go.gopls").tidy()
  end,
  desc = "run go mod tidy on save",
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = lsp_events_group,
  pattern = "*.go",
  callback = function()
    require("lb.cfg.lsp.servers.gopls").org_imports(5000)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = lsp_events_group,
  pattern = { "go", "gomod" },
  callback = function()
    vim.api.nvim_create_user_command("GoAddTagsJson", function()
      require("lb.go.tags").add("json", "-transform", "snakecase", "--skip-unexported")
    end, { nargs = 0 })

    vim.api.nvim_create_user_command("GoAddTagsXml", function()
      require("lb.go.tags").add("xml", "-transform", "snakecase", "--skip-unexported")
    end, { nargs = 0 })

    vim.api.nvim_create_user_command("GoRmTagsJson", function()
      require("lb.go.tags").rm "json"
    end, { nargs = 0 })

    vim.api.nvim_create_user_command("GoRmTagsXml", function()
      require("lb.go.tags").rm "xml"
    end, { nargs = 0 })

    vim.api.nvim_create_user_command("GoImpl", function(opts)
      require("lb.go.impl").run(unpack(opts.fargs))
    end, { complete = require("lb.go.impl").complete, nargs = "*" })

    vim.api.nvim_create_user_command("GoTestFile", function()
      require("lb.go.gotest").run_file()
    end, { nargs = 0 })

    vim.api.nvim_create_user_command("GoTest", function()
      require("lb.go.gotest").list_tests()
    end, { nargs = 0 })

    vim.api.nvim_create_user_command("GoMockGen", require("lb.go.mockgen").run, {
      nargs = "*",
      complete = function(_, _, _)
        return { "-p", "-d", "-i", "-s" }
      end,
    })
  end,
})
