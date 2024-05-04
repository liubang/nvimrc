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
