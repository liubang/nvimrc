--=====================================================================
--
-- aerial.lua -
--
-- Created by liubang on 2022/12/30 22:29
-- Last Modified: 2022/12/30 22:29
--
--=====================================================================
return {
  "stevearc/aerial.nvim",
  branch = "master",
  cmd = "AerialToggle",
  opts = {
    backends = { "lsp", "treesitter", "markdown" },
    layout = {
      default_direction = "prefer_right",
      placement = "edge",
    },
    attach_mode = "global", -- 'window' | 'global'
    nerd_font = "auto",
    show_guides = true,
    keymaps = {
      ["<CR>"] = false,
      ["o"] = "actions.jump",
      ["<C-j>"] = "actions.down_and_scroll",
      ["<C-k>"] = "actions.up_and_scroll",
      ["O"] = "actions.tree_toggle",
    },
  },
  keys = {
    { "<Leader>tl", "<CMD>AerialToggle<CR>", mode = { "n" }, desc = "Open or close the aerial window" },
  },
}

-- vim: fdm=marker fdl=0
