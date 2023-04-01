--=====================================================================
--
-- nvim-notify.lua -
--
-- Created by liubang on 2022/12/30 23:45
-- Last Modified: 2022/12/30 23:45
--
--=====================================================================
return {
  "rcarriga/nvim-notify",
  opts = { -- {{{
    timeout = 1000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
    -- stages = "fade",
  }, -- }}}
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        vim.notify = require "notify"
      end,
    })
    -- ---@diagnostic disable-next-line: duplicate-set-field
    -- vim.notify = function(...)
    --   require("lazy").load { plugins = { "nvim-notify" } }
    --   return require "notify"(...)
    -- end
  end,
}

-- vim: fdm=marker fdl=0
