--=====================================================================
--
-- venn.lua -
--
-- Created by liubang on 2022/10/16 18:15
-- Last Modified: 2022/10/23 02:51
--
--=====================================================================

vim.keymap.set("n", "<leader>v", function()
  local venn_enabled = vim.inspect(vim.b.venn_enabled)
  if venn_enabled == "nil" then
    vim.b.venn_enabled = true
    vim.opt_local.ve = "all"
    -- draw a line on HJKL keystokes
    vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
    -- draw a box by pressing "f" with visual selection
    vim.api.nvim_buf_set_keymap(0, "x", "f", ":VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "x", "F", ":VBoxH<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "x", "o", ":VBoxO<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "x", "d", ":VBoxD<CR>", { noremap = true })
  else
    vim.opt_local.ve = ""
    vim.cmd.mapclear "<buffer>"
    vim.b.venn_enabled = nil
  end
end, {})
