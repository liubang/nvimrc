-- Copyright (c) 2024 The Authors. All rights reserved.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      https://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- Authors: liubang (it.liubang@gmail.com)

local dap = require("dap")

require("plugins.dap.ui")

dap.listeners.after.event_initialized["dapui_config"] = function()
  require("dapui").open()
  vim.api.nvim_command("DapVirtualTextEnable")
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  vim.api.nvim_command("DapVirtualTextDisable")
end
