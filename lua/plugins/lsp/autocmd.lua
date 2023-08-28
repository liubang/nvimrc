--=====================================================================
--
-- autocmd.lua -
--
-- Created by liubang on 2022/10/18 00:38
-- Last Modified: 2022/12/10 20:49
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
    require("lb.go.gopls").org_imports(1000)
  end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--   group = lsp_events_group,
--   pattern = { "go", "gomod" },
--   callback = function()
--     vim.api.nvim_create_user_command("GoTidy", function() -- {{{
--       require("lb.go.gopls").tidy()
--     end, { nargs = 0 }) -- }}}
--
--     vim.api.nvim_create_user_command("GoInstallBinaries", function() -- {{{
--       require("lb.go.installer").install_all()
--     end, { nargs = 0 }) -- }}}
--
--     vim.api.nvim_create_user_command("GoUpdateBinaries", function() -- {{{
--       require("lb.go.installer").update_all()
--     end, { nargs = 0 }) -- }}}
--
--     vim.api.nvim_create_user_command("GoAddTagsJson", function(opts) -- {{{
--       require("lb.go.tags").add("json", "--skip-unexported", "-transform", opts.args)
--     end, {
--       nargs = 1,
--       complete = function()
--         return { "snakecase", "camelcase", "lispcase", "pascalcase", "titlecase" }
--       end,
--     }) -- }}}
--
--     vim.api.nvim_create_user_command("GoAddTagsXml", function(opts) -- {{{
--       require("lb.go.tags").add("xml", "--skip-unexported", "-transform", opts.args)
--     end, {
--       nargs = 1,
--       complete = function()
--         return { "snakecase", "camelcase", "lispcase", "pascalcase", "titlecase" }
--       end,
--     }) -- }}}
--
--     vim.api.nvim_create_user_command("GoAddTagsGorm", function(opts) -- {{{
--       require("lb.go.tags").add("gorm", "--skip-unexported", "-template", "column:{field}", "-transform", opts.args)
--     end, {
--       nargs = 1,
--       complete = function()
--         return { "snakecase", "camelcase", "lispcase", "pascalcase", "titlecase" }
--       end,
--     }) -- }}}
--
--     vim.api.nvim_create_user_command("GoRmTagsJson", function() -- {{{
--       require("lb.go.tags").rm "json"
--     end, { nargs = 0 }) -- }}}
--
--     vim.api.nvim_create_user_command("GoRmTagsXml", function() -- {{{
--       require("lb.go.tags").rm "xml"
--     end, { nargs = 0 }) -- }}}
--
--     vim.api.nvim_create_user_command("GoImpl", function(opts) -- {{{
--       require("lb.go.impl").run(unpack(opts.fargs))
--     end, { complete = require("lb.go.impl").complete, nargs = "*" }) -- }}}
--
--     vim.api.nvim_create_user_command("GoTestFile", function() -- {{{
--       require("lb.go.gotest").run_file()
--     end, { nargs = 0 }) -- }}}
--
--     vim.api.nvim_create_user_command("GoTest", function() -- {{{
--       require("lb.go.gotest").list_tests()
--     end, { nargs = 0 }) -- }}}
--
--     vim.api.nvim_create_user_command("GoMockGen", require("lb.go.mockgen").run, { -- {{{
--       nargs = "*",
--       complete = function(_, _, _)
--         return { "-package", "-destination", "-interface", "-source" }
--       end,
--     }) -- }}}
--   end,
-- })

-- vim: foldmethod=marker foldlevel=0
