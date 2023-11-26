--=====================================================================
--
-- gruvbox-material.lua -
--
-- Created by liubang on 2023/11/26 15:56
-- Last Modified: 2023/11/26 15:56
--
--=====================================================================

return {
  "sainnhe/gruvbox-material", -- {{{
  lazy = false,
  priority = 1000,
  config = function()
    vim.o.background = "dark"
    vim.o.guifont = "Operator Mono Lig:h18,Hack Nerd Font:h18"

    -- neowide {{{
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_cursor_vfx_mode = "railgun"
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
    vim.g.gruvbox_material_foreground = "material"
    vim.g.gruvbox_filetype_hi_groups = 0
    vim.g.gruvbox_plugin_hi_groups = 0
    vim.g.gruvbox_transp_bg = 1
    vim.g.gruvbox_material_enable_italic = 0
    vim.g.gruvbox_material_disable_italic_comment = 0
    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_disable_italic_comment = 1
    -- }}}

    vim.cmd.colorscheme("gruvbox-material")
    vim.o.foldtext = 'v:lua.require("lb.utils.fold").foldtext()'
  end,
}
