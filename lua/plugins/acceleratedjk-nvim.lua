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

return {
  "rainbowhxch/accelerated-jk.nvim", -- {{{
  keys = {
    { "j", "<Plug>(accelerated_jk_gj)", mode = { "n" }, desc = "Accelerated gj movement" },
    { "k", "<Plug>(accelerated_jk_gk)", mode = { "n" }, desc = "Accelerated gk movement" },
  },
  opts = {
    mode = "time_driven",
    enable_deceleration = false,
    acceleration_motions = {},
    acceleration_limit = 150,
    acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },
    deceleration_table = { { 150, 9999 } },
  },
  -- }}}
}
-- vim: fdm=marker fdl=0
