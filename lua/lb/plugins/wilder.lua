--=====================================================================
--
-- wilder.lua -
--
-- Created by liubang on 2022/12/30 21:57
-- Last Modified: 2022/12/30 21:57
--
--=====================================================================
local M = {
  "gelguy/wilder.nvim",
  dependencies = {
    "romgrk/fzy-lua-native",
    build = "make",
  },
  build = ":lua vim.defer_fn(function() vim.cmd.UpdateRemotePlugins() end, 500)",
  event = "CmdlineEnter",
}

function M.config()
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
        highlights = {
          accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#ea6962" } }),
        },
      },
      ["/"] = wilder.wildmenu_renderer {
        highlighter = wilder.lua_fzy_highlighter(),
        highlights = {
          accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#ea6962" } }),
        },
      },
    }
  )
end

return M

-- vim: fdm=marker fdl=0
