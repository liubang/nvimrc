--=====================================================================
--
-- gotest.lua -
--
-- Created by liubang on 2022/09/24 13:25
-- Last Modified: 2022/12/18 21:22
--
--=====================================================================

local M = {}
local cleancmd = "go clean -testcache"
local testcmd = "go test -v -gcflags=all=-l"

local get_test_path = function()
  local fpath = vim.fn.expand "%:p:h"
  local root = vim.lsp.buf.list_workspace_folders()[1]
  if not root then
    root = require("lb.utils.util").root_pattern("go.mod", ".git")(vim.fn.expand "%:p")
  end
  local s, e, _ = string.find(fpath, root, 1, true)
  if s ~= nil and e ~= nil then
    fpath = "." .. string.sub(fpath, e + 1)
  end
  return fpath
end

M.run_file = function()
  local fpath = get_test_path()
  vim.schedule(function()
    local cmd = string.format("AsyncRun -mode=term -pos=floaterm %s && %s %s", cleancmd, testcmd, fpath)
    vim.cmd(cmd)
  end)
end

M.list_tests = function()
  local test_names = require("lb.ts.go").list_test_func()
  local fpath = get_test_path()
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
