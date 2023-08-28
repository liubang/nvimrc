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
  build = "make install_jsregexp",
  dependencies = { "rafamadriz/friendly-snippets" },
  opts = function()
    local types = require "luasnip.util.types"
    return {
      history = true,
      update_events = "TextChanged,TextChangedI",
      delete_check_events = "TextChanged,InsertLeave",
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
  end,
  keys = {
    {
      "<C-n>",
      function()
        local ls = require "luasnip"
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end,
      mode = { "i", "s" },
    },
    {
      "<C-p>",
      function()
        local ls = require "luasnip"
        if ls.choice_active() then
          ls.change_choice(-1)
        end
      end,
      mode = { "i", "s" },
    },
    {
      "<tab>",
      function()
        return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
      end,
      expr = true,
      silent = true,
      mode = "i",
    },
    {
      "<tab>",
      function()
        require("luasnip").jump(1)
      end,
      mode = "s",
    },
    {
      "<s-tab>",
      function()
        require("luasnip").jump(-1)
      end,
      mode = { "i", "s" },
    },
  },
  config = function(_, opts)
    require("luasnip").setup(opts)
    require "plugins.snips.all"
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}

-- vim: fdm=marker fdl=0
