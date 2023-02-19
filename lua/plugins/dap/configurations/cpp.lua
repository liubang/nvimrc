--=====================================================================
--
-- cpp.lua -
--
-- Created by liubang on 2023/02/18 21:37
-- Last Modified: 2023/02/19 13:14
--
--=====================================================================
local dap = require "dap"

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = true,
    setupCommands = {
      {
        description = "enable pretty printing",
        text = "-enable-pretty-printing",
        ignoreFailures = false,
      },
    },
  },
  {
    name = "Attach process",
    type = "cppdbg",
    request = "attach",
    processId = require("dap.utils").pick_process,
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    setupCommands = {
      {
        description = "enable pretty printing",
        text = "-enable-pretty-printing",
        ignoreFailures = false,
      },
    },
  },
}
