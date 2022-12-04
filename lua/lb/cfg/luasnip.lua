-- =====================================================================
--
-- luasnip.lua -
--
-- Created by liubang on 2021/09/04 21:07
-- Last Modified: 2022/11/12 23:19
--
-- =====================================================================

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
