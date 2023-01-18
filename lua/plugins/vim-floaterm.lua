--=====================================================================
--
-- vim-floaterm.lua -
--
-- Created by liubang on 2022/12/30 22:18
-- Last Modified: 2022/12/30 22:18
--
--=====================================================================
return {
  "voldikss/vim-floaterm",
  config = function()
    vim.g.floaterm_wintype = "float"
    vim.g.floaterm_position = "bottom"
    vim.g.floaterm_autoinsert = true
    vim.g.floaterm_width = 0.999
    vim.g.floaterm_height = 0.7
    vim.g.floaterm_title = "─────  Floaterm [$1|$2] "
  end,
  cmd = { "FloatermNew", "FloatermToggle", "FloatermPrev", "FloatermNext" },
  keys = {
    { "<C-t>", "<CMD>FloatermToggle<CR>", desc = "Toggle floaterm" },
    {
      "<C-n>",
      vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermNew<CR>", true, true, true),
      mode = { "t" },
      desc = "Create a new floaterm window",
    },
    {
      "<C-k>",
      vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermPrev<CR>", true, true, true),
      mode = { "t" },
      desc = "Goto previous floaterm window",
    },
    {
      "<C-j>",
      vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermNext<CR>", true, true, true),
      mode = { "t" },
      desc = "Goto next floaterm window",
    },
    {
      "<C-t>",
      vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermToggle<CR>", true, true, true),
      mode = { "t" },
      desc = "Toggle floaterm",
    },
    {
      "<C-d>",
      vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermKill<CR>", true, true, true),
      mode = { "t" },
      desc = "Kill floaterm",
    },
  },
}

-- vim: fdm=marker fdl=0
