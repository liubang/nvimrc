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
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = (not jit.os:find("Windows"))
      and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
    or nil,
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },
  opts = {
    history = true,
    delete_check_events = "TextChanged",
  },
  keys = {
    {
      "<C-n>",
      function()
        local ls = require("luasnip")
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end,
      mode = { "i", "s" },
    },
    {
      "<C-p>",
      function()
        local ls = require("luasnip")
        if ls.choice_active() then
          ls.change_choice(-1)
        end
      end,
      mode = { "i", "s" },
    },
  },
  config = function(_, opts)
    require("luasnip").setup(opts)
    require("plugins.snips.all")
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}

-- vim: fdm=marker fdl=0
