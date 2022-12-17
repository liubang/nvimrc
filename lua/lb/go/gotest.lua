--=====================================================================
--
-- gotest.lua -
--
-- Created by liubang on 2022/09/24 13:25
-- Last Modified: 2022/12/18 00:21
--
--=====================================================================
local tsgo = require "lb.ts.go"

local M = {}
local cleancmd = "go clean -testcache"
local testcmd = "go test -v -gcflags=all=-l"

M.run_file = function()
  local fpath = "/" .. vim.fn.expand "%:h" .. "/"
  local cmd = string.format("AsyncRun -mode=term -pos=floaterm %s && %s %s", cleancmd, testcmd, fpath)
  vim.schedule(function()
    vim.cmd(cmd)
  end)
end

M.list_tests = function()
  local test_names = tsgo.list_test_func()
  local fpath = "./" .. vim.fn.expand "%:h" .. "/"
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
