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
  "gelguy/wilder.nvim", -- {{{
  dependencies = { "romgrk/fzy-lua-native" },
  -- enabled = false,
  event = "CmdlineEnter",
  config = function()
    local wilder = require("wilder")

    wilder.setup({ modes = { ":", "/", "?" } })
    -- Disable Python remote plugin
    wilder.set_option("use_python_remote_plugin", 0)
    wilder.set_option("pipeline", {
      wilder.branch(
        wilder.cmdline_pipeline({
          fuzzy = 1,
          use_python = 0,
          fuzzy_filter = wilder.lua_fzy_filter(),
        }),
        wilder.vim_search_pipeline()
      ),
    })

    wilder.set_option(
      "renderer",
      wilder.renderer_mux({
        [":"] = wilder.wildmenu_renderer({
          -- max_width = 14,
          -- max_height = 17,
          highlighter = wilder.lua_fzy_highlighter(),
          -- left = {
          --   " ",
          --   wilder.popupmenu_devicons(),
          -- },
          -- right = {
          --   " ",
          --   wilder.popupmenu_scrollbar(),
          -- },
          highlights = {
            accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#ea6962" } }),
          },
        }),
        ["/"] = wilder.wildmenu_renderer({
          highlighter = wilder.lua_fzy_highlighter(),
          highlights = {
            accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#ea6962" } }),
          },
        }),
      })
    )
  end,
  -- }}}
}
