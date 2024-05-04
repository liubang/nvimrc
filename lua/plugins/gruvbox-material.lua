-- Copyright (c) 2024 The Authors. All rights reserved.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      https://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- Authors: liubang (it.liubang@gmail.com)

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
