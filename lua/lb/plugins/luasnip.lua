--=====================================================================
--
-- luasnip.lua -
--
-- Created by liubang on 2022/12/30 21:51
-- Last Modified: 2022/12/30 21:51
--
--=====================================================================

return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  config = function()
    local ls = require "luasnip"
    local types = require "luasnip.util.types"

    ls.config.setup {
      history = true,
      updateevents = "TextChanged,TextChangedI",
      delete_check_events = "TextChanged",
      -- Autosnippets:
      enable_autosnippets = true,
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { " « ", "Comment" } },
          },
        },
      },
    }

    vim.keymap.set({ "i", "s" }, "<C-n>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, {})

    vim.keymap.set({ "i", "s" }, "<C-p>", function()
      if ls.choice_active() then
        ls.change_choice(-1)
      end
    end, {})

    require "lb.snips.all"
    require "lb.snips.c"
    require "lb.snips.cpp"
    require "lb.snips.rust"
    require "lb.snips.go"
    require "lb.snips.lua"
    require "lb.snips.markdown"
  end,
}

-- vim: fdm=marker fdl=0
