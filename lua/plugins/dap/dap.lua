--=====================================================================
--
-- dap.lua -
--
-- Created by liubang on 2023/02/18 21:32
-- Last Modified: 2023/02/18 21:32
--
--=====================================================================

local dap = require "dap"

local breakpoint = {
  text = "",
  texthl = "DiagnosticSignError",
  linehl = "",
  numhl = "",
}

local breakpoint_rejected = {
  text = "",
  texthl = "DiagnosticSignError",
  linehl = "",
  numhl = "",
}

local stopped = {
  text = "",
  texthl = "DiagnosticSignWarn",
  linehl = "Visual",
  numhl = "DiagnosticSignWarn",
}

vim.fn.sign_define("DapBreakpoint", breakpoint)
vim.fn.sign_define("DapBreakpointRejected", breakpoint_rejected)
vim.fn.sign_define("DapStopped", stopped)

dap.listeners.after.event_initialized["dapui_config"] = function()
  require("dapui").open()
end

for _, adapter in ipairs {
  "cppdbg",
  "go",
} do
  dap.adapters[adapter] = require("plugins.dap.adapters." .. adapter)
end

for _, cfg in ipairs {
  "cpp",
  "go",
} do
  dap.configurations[cfg] = require("plugins.dap.configurations." .. cfg)
end
