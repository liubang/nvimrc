--=====================================================================
--
-- go.lua -
--
-- Created by liubang on 2023/02/18 21:27
-- Last Modified: 2023/02/18 21:27
--
--=====================================================================
local dap = require "dap"

dap.configurations.go = {
  {
    type = "go",
    name = "Debug (from vscode-go)",
    request = "launch",
    showLog = false,
    program = "${file}",
  },
  {
    type = "go",
    name = "Test Current File",
    request = "launch",
    showLog = true,
    mode = "test",
    program = "${file}",
  },
  {
    type = "go",
    name = "Attach process",
    mode = "local",
    request = "attach",
    processId = require("dap.utils").pick_process,
  },
  {
    type = "go",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    showLog = true,
    program = "./${relativeFileDirname}",
  },
}
