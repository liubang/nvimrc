--=====================================================================
--
-- lazy.lua -
--
-- Created by liubang on 2023/10/28 21:29
-- Last Modified: 2023/10/28 21:29
--
--=====================================================================

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
