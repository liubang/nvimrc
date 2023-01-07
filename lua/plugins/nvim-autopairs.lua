--=====================================================================
--
-- nvim-autopairs.lua -
--
-- Created by liubang on 2022/12/30 21:55
-- Last Modified: 2022/12/30 21:55
--
--=====================================================================
return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  config = function()
    require("nvim-autopairs").setup {
      check_ts = true,
      ignored_next_char = "[%w%.]",
      ts_config = {
        lua = { "string", "source" },
      },
      fast_wrap = {
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
      disable_filetype = { "TelescopePrompt", "vim" },
    }

    require("cmp").event:on(
      "confirm_done",
      require("nvim-autopairs.completion.cmp").on_confirm_done { map_char = { tex = "" } }
    )
  end,
}

-- vim: fdm=marker fdl=0
