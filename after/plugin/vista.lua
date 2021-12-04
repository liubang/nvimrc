--=====================================================================
--
-- vista.lua -
--
-- Created by liubang on 2021/07/14 17:21
-- Last Modified: 2021/07/14 17:21
--
--=====================================================================
local get_vista_open_cmd = function()
  local w = vim.fn.winwidth '%'
  if w >= 160 then
    return '80vsplit'
  elseif w >= 100 then
    return '50vsplit'
  elseif w >= 80 then
    return '40vsplit'
  end
  return 'split'
end

vim.g.vista_echo_cursor = 0
vim.g.vista_default_executive = 'nvim_lsp'
vim.g.vista_no_mappings = 1
vim.g.vista_sidebar_open_cmd = get_vista_open_cmd()
vim.g.vista_disable_statusline = 1
