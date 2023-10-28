--=====================================================================
--
-- health.lua -
--
-- Created by liubang on 2022/09/12 01:38
-- Last Modified: 2022/12/31 22:32
--
--=====================================================================

local M = {}
local health = vim.health or require("health")

local check_executable = function(bin, name, advice) -- {{{
  if vim.fn.executable(bin) == 0 then
    health.error(string.format("Please install %s, %s", name, advice))
  else
    health.ok(string.format("%s is installed", name))
  end
end -- }}}

M.check = function() -- {{{
  health.start("Checking nvim configuration requirements")
  check_executable("yarn", "yarn", "Refer to https://classic.yarnpkg.com/en/docs/install")
  check_executable("rg", "ripgrep", "Refer to https://github.com/BurntSushi/ripgrep#installation")
end -- }}}

return M

-- vim: fdm=marker fdl=0
