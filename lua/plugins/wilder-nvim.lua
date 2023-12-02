--=====================================================================
--
-- wilder-nvim.lua -
--
-- Created by liubang on 2023/11/26 16:04
-- Last Modified: 2023/11/26 16:04
--
--=====================================================================

return {
  "gelguy/wilder.nvim", -- {{{
  dependencies = { "romgrk/fzy-lua-native" },
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
