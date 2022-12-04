--=====================================================================
--
-- sumneko_lua.lua -
--
-- Created by liubang on 2022/08/06 00:26
-- Last Modified: 2022/12/04 03:01
--
--=====================================================================
local lspconfig = require "lspconfig"
local c = require "lb.cfg.lsp.customs"

local function get_lua_runtime()
  local result = {}
  for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
    local lua_path = path .. "/lua/"
    if vim.fn.isdirectory(lua_path) then
      result[lua_path] = true
    end
  end
  result[vim.fn.expand "$VIMRUNTIME/lua"] = true
  return result
end

local setup = function()
  lspconfig.sumneko_lua.setup(c.default {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = {
          enable = true,
          globals = { "vim", "packer_plugins", "planery" },
        },
        workspace = {
          library = get_lua_runtime(),
          maxPreload = 10000,
          preloadFileSize = 10000,
        },
      },
    },
  })
end

return {
  setup = setup,
}
