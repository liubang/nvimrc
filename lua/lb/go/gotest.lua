--=====================================================================
--
-- gotest.lua -
--
-- Created by liubang on 2022/09/24 13:25
-- Last Modified: 2022/09/24 13:25
--
--=====================================================================

local tsgo = require "lb.ts.go"

local M = {}
local cleancmd = "go clean -testcache"
local testcmd = "go test -v -gcflags=all=-l"

M.run_file = function()
  local fpath = vim.fn.expand "%:p:h" .. "/"
  local cmd = string.format("AsyncRun -mode=term -pos=floaterm %s && %s %s", cleancmd, testcmd, fpath)
  vim.schedule(function()
    vim.cmd(cmd)
  end)
end

M.list_tests = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local tree = vim.treesitter.get_parser(bufnr):parse()[1]
  local query = vim.treesitter.parse_query("go", tsgo.query_test_func)

  local test_names = {}
  for id, node, _ in query:iter_captures(tree:root(), bufnr, 0, -1) do
    local name = query.captures[id]
    if name == "test_name" then
      table.insert(test_names, vim.treesitter.get_node_text(node, bufnr))
    end
  end
  local fpath = vim.fn.expand "%:p:h" .. "/"
  vim.ui.select(test_names, {
    prompt = "Select Test Function",
  }, function(choice)
    vim.schedule(function()
      local cmd =
        string.format("AsyncRun -mode=term -pos=floaterm %s && %s -run=%s %s", cleancmd, testcmd, choice, fpath)
      vim.cmd(cmd)
    end)
  end)
end

return M
