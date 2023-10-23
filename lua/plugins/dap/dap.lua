--=====================================================================
--
-- dap.lua -
--
-- Created by liubang on 2023/02/18 21:32
-- Last Modified: 2023/02/19 02:18
--
--=====================================================================

local dap = require 'dap'

require 'nvim-dap-virtual-text'
require 'plugins.dap.adapters'
require 'plugins.dap.configurations'

local breakpoint = {
    text = '',
    texthl = 'DiagnosticSignError',
    linehl = '',
    numhl = '',
}

local breakpoint_rejected = {
    text = '',
    texthl = 'DiagnosticSignError',
    linehl = '',
    numhl = '',
}

local stopped = {
    text = '',
    texthl = 'DiagnosticSignWarn',
    linehl = 'Visual',
    numhl = 'DiagnosticSignWarn',
}

vim.fn.sign_define('DapBreakpoint', breakpoint)
vim.fn.sign_define('DapBreakpointRejected', breakpoint_rejected)
vim.fn.sign_define('DapStopped', stopped)

dap.listeners.after.event_initialized['dapui_config'] = function()
    require('dapui').open()
    vim.api.nvim_command 'DapVirtualTextEnable'
end

dap.listeners.before.event_terminated['dapui_config'] = function()
    vim.api.nvim_command 'DapVirtualTextDisable'
end
