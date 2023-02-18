--=====================================================================
--
-- dap.lua -
--
-- Created by liubang on 2023/02/18 21:32
-- Last Modified: 2023/02/19 02:18
--
--=====================================================================

local dap = require "dap"
local M = {}

local config_style = function()
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
end

local config_event = function()
  dap.listeners.after.event_initialized["dapui_config"] = function()
    require("dapui").open()
  end
end

local setup_adapter = function()
  for _, adapter in ipairs {
    "cppdbg",
    "codelldb",
    "go",
  } do
    dap.adapters[adapter] = require("plugins.dap.adapters." .. adapter)
  end
end

local setup_configs = function()
  for _, lang in ipairs {
    "cpp",
    "go",
    "rust",
  } do
    dap.configurations[lang] = require("plugins.dap.configurations." .. lang)
  end
end

function M.setup()
  config_style()
  config_event()
  setup_adapter()
  setup_configs()
end

return M
