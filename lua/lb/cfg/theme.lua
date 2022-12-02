-- =====================================================================
--
-- theme.lua -
--
-- Created by liubang on 2020/12/12 21:20
-- Last Modified: 2022/12/03 00:45
--
-- =====================================================================

vim.opt.background = 'dark'

-- neowide {{{
vim.opt.guifont = 'Operator Mono Lig:h16,Hack Nerd Font:h16'
vim.g.neovide_refresh_rate = 60
vim.g.neovide_cursor_vfx_mode = 'railgun'
vim.g.neovide_no_idle = true
vim.g.neovide_cursor_animation_length = 0.03
vim.g.neovide_cursor_trail_length = 0.05
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_vfx_opacity = 200.0
vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
vim.g.neovide_cursor_vfx_particle_speed = 20.0
vim.g.neovide_cursor_vfx_particle_density = 5.0
-- }}}

-- theme {{{
vim.g.gruvbox_material_foreground = 'material'
vim.g.gruvbox_filetype_hi_groups = 1
vim.g.gruvbox_plugin_hi_groups = 1
vim.g.gruvbox_transp_bg = 1
vim.g.gruvbox_material_enable_italic = 0
vim.g.gruvbox_material_disable_italic_comment = 0
vim.g.gruvbox_material_background = 'soft'
vim.g.gruvbox_material_better_performance = 1
-- }}}

vim.api.nvim_create_autocmd('UIEnter', { --{{{
  callback = function()
    vim.cmd.colorscheme 'gruvbox-material'
    -- _G.custom_foldtext = require('lb.utils.fold').foldtext
    -- vim.opt.foldtext = 'v:lua.custom_foldtext()'
    vim.o.foldtext = 'v:lua.require("lb.utils.fold").foldtext()'
  end,
}) --}}}

-- vim: fdm=marker fdl=0
