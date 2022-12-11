--=====================================================================
--
-- wilder.lua -
--
-- Created by liubang on 2022/12/11 03:47
-- Last Modified: 2022/12/11 03:47
--
--=====================================================================

vim.cmd.packadd "fzy-lua-native"

local wilder = require "wilder"

wilder.setup { modes = { ":", "/", "?" } }

-- Disable Python remote plugin
wilder.set_option("use_python_remote_plugin", 0)

wilder.set_option("pipeline", {
  wilder.branch(
    wilder.cmdline_pipeline {
      fuzzy = 1,
      fuzzy_filter = wilder.lua_fzy_filter(),
    },
    wilder.vim_search_pipeline()
  ),
})

wilder.set_option(
  "renderer",
  wilder.renderer_mux {
    [":"] = wilder.popupmenu_renderer {
      max_width = 14,
      max_height = 17,
      highlighter = wilder.lua_fzy_highlighter(),
      left = {
        " ",
        wilder.popupmenu_devicons(),
      },
      right = {
        " ",
        wilder.popupmenu_scrollbar(),
      },
    },
    ["/"] = wilder.wildmenu_renderer {
      highlighter = wilder.lua_fzy_highlighter(),
    },
  }
)
