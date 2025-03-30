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

local M = {}
local capabilities = require("blink.cmp").get_lsp_capabilities()

M.default = function(configs)
  configs = configs or {}
  local caps = vim.tbl_deep_extend("force", capabilities, configs.capabilities or {})
  local custom_config = {
    capabilities = caps,
  }
  if configs ~= nil then
    for key, value in pairs(configs) do
      if key ~= "capabilities" then
        custom_config[key] = value
      end
    end
  end
  return custom_config
end

return M
