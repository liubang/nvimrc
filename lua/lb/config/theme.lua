-- =====================================================================
--
-- theme.lua - 
--
-- Created by liubang on 2020/12/12 21:20
-- Last Modified: 2020/12/12 21:20
--
-- =====================================================================
if os.getenv('TMUX') ~= nil then
  vim.cmd [[let $NVIM_TUI_ENABLE_TRUE_COLOR=1]]
  if vim.fn.has('termguicolors') then
    vim.cmd [[set t_8f=^[[38;2;%lu;%lu;%lum]]
    vim.cmd [[set t_8b=^[[48;2;%lu;%lu;%lum]]
    vim.cmd [[set termguicolors]]
  else
    vim.cmd [[set t_Co=256]]
  end
end

-- 退出后清屏
-- if vim.api.nvim_get_option('term'):match('xterm') then
--   vim.cmd [[let &t_ti = "\<Esc>[?47h"]]
--   vim.cmd [[let &t_te = "\<Esc>[?47l"]]
-- end

-- hide ~
vim.o.background = 'dark'
vim.g.gruvbox_filetype_hi_groups = 1
vim.g.gruvbox_plugin_hi_groups = 1
vim.g.gruvbox_transp_bg = 1
vim.g.gruvbox_material_enable_italic = 0
vim.g.gruvbox_material_disable_italic_comment = 1
vim.g.gruvbox_material_background = 'soft'

vim.cmd [[colorscheme gruvbox-material]]
vim.cmd [[hi Whitespace ctermfg=96 guifg=#725972 guibg=NONE ctermbg=NONE]]
