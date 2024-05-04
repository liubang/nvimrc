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

local Util = require("lazy.util")
local core = require("lazy.core.plugin").Spec.new({ import = "plugins" })

Util.foreach(core.plugins, function(_, plugin)
  vim.print(plugin)
  for _, key in ipairs(plugin.keys or {}) do
    if type(key) == "table" and key.desc then
      -- local desc = key.desc or ""
      -- desc = ("[%s](%s)"):format(plugin.name, plugin.url) .. " " .. desc
      -- map(key.mode or "n", key[1], key[2], { desc = desc })
    end
  end
end)
