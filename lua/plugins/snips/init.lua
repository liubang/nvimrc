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
