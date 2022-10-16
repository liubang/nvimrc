--=====================================================================
--
-- venn.lua -
--
-- Created by liubang on 2022/10/16 18:15
-- Last Modified: 2022/10/16 18:15
--
--=====================================================================

vim.keymap.set('n', '<leader>v', function()
  local venn_enabled = vim.inspect(vim.b.venn_enabled)
  if venn_enabled == 'nil' then
    vim.b.venn_enabled = true
    vim.opt_local.ve = 'all'
    vim.keymap.set('n', 'H', '<C-v>h:VBox<CR>', { buffer = true })
    vim.keymap.set('n', 'J', '<C-v>j:VBox<CR>', { buffer = true })
    vim.keymap.set('n', 'K', '<C-v>k:VBox<CR>', { buffer = true })
    vim.keymap.set('n', 'L', '<C-v>l:VBox<CR>', { buffer = true })
    vim.keymap.set('v', 'f', ':VBox<CR>', { buffer = true })
    vim.keymap.set('v', 'F', ':VBoxH<CR>', { buffer = true })
    vim.keymap.set('v', 'o', ':VBoxO<CR>', { buffer = true })
    vim.keymap.set('v', 'd', ':VBoxD<CR>', { buffer = true })
    return
  end

  vim.opt_local.ve = ''
  vim.cmd.mapclear '<buffer>'
  vim.b.venn_enabled = nil
end, {})
