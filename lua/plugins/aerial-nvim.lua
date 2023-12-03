--=====================================================================
--
-- aerial-nvim.lua -
--
-- Created by liubang on 2023/11/26 15:59
-- Last Modified: 2023/11/26 15:59
--
--=====================================================================

return {
  "stevearc/aerial.nvim", -- {{{
  cmd = "AerialToggle",
  opts = {
    backends = { "lsp", "markdown" },
    layout = {
      default_direction = "prefer_right",
      placement = "edge",
    },
    attach_mode = "window", -- 'window' | 'global'
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
  -- }}}
}
