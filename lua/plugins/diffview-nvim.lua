--=====================================================================
--
-- diffview-nvim.lua -
--
-- Created by liubang on 2023/11/26 16:10
-- Last Modified: 2023/11/26 16:10
--
--=====================================================================

return {
  "sindrets/diffview.nvim",
  keys = {
    { "<leader>df", "<cmd>DiffviewFileHistory<cr>", desc = "File history" },
    { "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "Diff view" },
  },
  opts = function()
    local actions = require("diffview.actions")
    require("diffview.ui.panel").Panel.default_config_float.border = "single"
    return {
      default_args = { DiffviewFileHistory = { "%" } },
      -- Disable mappings I don't use and use ? instead of g? for help.
      keymaps = {
        view = {
          ["<C-w><C-f>"] = false,
          ["<leader>e"] = false,
        },
        diff1 = {
          ["g?"] = false,
          { "n", "?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
        },
        diff2 = {
          ["g?"] = false,
          { "n", "?", actions.help({ "view", "diff2" }), { desc = "Open the help panel" } },
        },
        diff3 = {
          ["g?"] = false,
          { "n", "?", actions.help({ "view", "diff3" }), { desc = "Open the help panel" } },
        },
        diff4 = {
          ["g?"] = false,
          { "n", "?", actions.help({ "view", "diff4" }), { desc = "Open the help panel" } },
        },
        file_panel = {
          ["<down>"] = false,
          ["<up>"] = false,
          ["o"] = false,
          ["l"] = false,
          ["<2-LeftMouse>"] = false,
          ["-"] = false,
          ["h"] = false,
          ["<C-w><C-f>"] = false,
          ["<leader>e"] = false,
          ["g?"] = false,
          { "n", "?", actions.help("file_panel"), { desc = "Open the help panel" } },
        },
        file_history_panel = {
          ["<C-A-d>"] = false,
          ["h"] = false,
          ["<down>"] = false,
          ["<up>"] = false,
          ["o"] = false,
          ["l"] = false,
          ["<2-LeftMouse>"] = false,
          ["<C-w><C-f>"] = false,
          ["<leader>e"] = false,
          ["g?"] = false,
          ["g!"] = false,
          { "n", "?", actions.help("file_history_panel"), { desc = "Open the help panel" } },
          { "n", "!", actions.options, { desc = "Open the option panel" } },
          {
            "n",
            "<leader>d",
            actions.open_in_diffview,
            { desc = "Open the entry under the cursor in a diffview" },
          },
        },
        option_panel = {
          ["g?"] = false,
          { "n", "?", actions.help("option_panel"), { desc = "Open the help panel" } },
        },
      },
    }
  end,
}
