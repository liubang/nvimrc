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
  "hedyhli/outline.nvim",
  cmd = { "Outline" },
  opts = {
    position = "right",
    width = 25,
    symbol_folding = { autofold_depth = 5 },
    providers = {
      priority = { "lsp", "coc", "markdown", "norg", "man" },
      lsp = {
        blacklist_clients = { "spring-boot" },
      },
    },
    -- Use Nerd Font icons matching blink.cmp's style (all Nerd Font glyphs, no mixed Unicode/emoji)
    symbols = {
      icon_source = nil, -- don't use lspkind
      -- Use mini.icons for a consistent Nerd Font (nf-cod-*) icon set
      icon_fetcher = function(kind, bufnr, symbol)
        local ok, mini_icons = pcall(require, "mini.icons")
        if ok then
          local icon = mini_icons.get("lsp", kind:lower())
          if icon and icon ~= "" then
            return icon
          end
        end
        return nil -- fall through to symbols.icons below
      end,
      icons = {
        -- Fallback icons — all Nerd Font glyphs matching blink.cmp style
        File = { icon = "󰈔", hl = "Identifier" },
        Module = { icon = "󰅩", hl = "Include" },
        Namespace = { icon = "󰅪", hl = "Include" },
        Package = { icon = "󰏗", hl = "Include" },
        Class = { icon = "󱡠", hl = "Type" },
        Method = { icon = "󰊕", hl = "Function" },
        Property = { icon = "󰖷", hl = "Identifier" },
        Field = { icon = "󰜢", hl = "Identifier" },
        Constructor = { icon = "󰒓", hl = "Special" },
        Enum = { icon = "󰦨", hl = "Type" },
        Interface = { icon = "󱡠", hl = "Type" },
        Function = { icon = "󰊕", hl = "Function" },
        Variable = { icon = "󰆦", hl = "Constant" },
        Constant = { icon = "󰏿", hl = "Constant" },
        String = { icon = "󰉿", hl = "String" },
        Number = { icon = "󰎞", hl = "Number" },
        Boolean = { icon = "󰨙", hl = "Boolean" },
        Array = { icon = "󰅪", hl = "Constant" },
        Object = { icon = "󰅩", hl = "Type" },
        Key = { icon = "󰌆", hl = "Type" },
        Null = { icon = "󰟢", hl = "Type" },
        EnumMember = { icon = "󰦨", hl = "Identifier" },
        Struct = { icon = "󱡠", hl = "Structure" },
        Event = { icon = "󱐋", hl = "Type" },
        Operator = { icon = "󰪚", hl = "Identifier" },
        TypeParameter = { icon = "󰬛", hl = "Identifier" },
        Component = { icon = "󰅴", hl = "Function" },
        Fragment = { icon = "󰅴", hl = "Constant" },
        -- ccls extras
        TypeAlias = { icon = "󰝒", hl = "Type" },
        Parameter = { icon = "󰆦", hl = "Identifier" },
        StaticMethod = { icon = "󰊕", hl = "Function" },
        Macro = { icon = "󰌁", hl = "Function" },
      },
    },
  },
  keys = {
    { "<Leader>tl", "<CMD>Outline<CR>", mode = { "n" }, desc = "Open or close the outline window" },
  },
}

-- return {
--   "stevearc/aerial.nvim", -- {{{
--   cmd = "AerialToggle",
--   opts = {
--     backends = { "lsp", "markdown", "man" },
--     layout = {
--       max_width = { 40, 0.25 },
--       min_width = 16,
--       resize_to_content = true,
--       preserve_equality = true,
--     },
--     attach_mode = "window",
--     nerd_font = "auto",
--     show_guides = true,
--     guides = {
--       mid_item = "├╴",
--       last_item = "└╴",
--       nested_top = "│ ",
--       whitespace = "  ",
--     },
--     keymaps = {
--       ["<CR>"] = false,
--       ["o"] = "actions.jump",
--       ["<C-j>"] = "actions.down_and_scroll",
--       ["<C-k>"] = "actions.up_and_scroll",
--       ["O"] = "actions.tree_toggle",
--       ["q"] = {
--         callback = function()
--           vim.cmd("AerialClose")
--         end,
--         desc = "Close the aerial window",
--         nowait = true,
--       },
--     },
--   },
--   keys = {
--     { "<Leader>tl", "<CMD>AerialToggle<CR>", mode = { "n" }, desc = "Open or close the aerial window" },
--   },
--   -- }}}
-- }
