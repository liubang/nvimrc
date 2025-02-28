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
  {
    "hrsh7th/nvim-cmp", -- {{{
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "saadparwaiz1/cmp_luasnip",
    },
    event = { "InsertEnter" },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local config = require("lb.config")
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      cmp.setup({
        performance = {
          debounce = 50,
          throttle = 10,
        },
        completion = { completeopt = "menu,menuone,preview" },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        preselect = cmp.PreselectMode.None,
        sources = {
          { name = "nvim_lsp", priority = 80 },
          { name = "luasnip", priority = 10 },
          { name = "calc", group_index = 3 },
          { name = "path", priority = 40 },
          {
            name = "buffer",
            priority = 5,
            keywork_length = 3,
            group_index = 5,
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end,
            },
          },
          { name = "crates" },
          { name = "latex_symbols" },
        },
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.recently_used,
            require("clangd_extensions.cmp_scores"),
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        window = {
          completion = {
            scrollbar = false,
          },
        },
        formatting = {
          fields = { "abbr", "kind" },
          format = function(entry, item)
            if vim.tbl_contains({ "path" }, entry.source.name) then
              local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
              if icon then
                item.kind = icon
                item.kind_hl_group = hl_group
                return item
              end
            end
            local max_width = 70
            if vim.fn.strdisplaywidth(item.abbr) > max_width then
              item.abbr = vim.fn.strcharpart(item.abbr, 0, max_width - 1) .. "…"
            end
            item.kind = string.format("%s  %-9s", config.kinds[item.kind], item.kind)
            -- clear item menu
            item.menu = ""
            return item
          end,
        },
        view = {
          docs = {
            auto_open = false,
          },
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        experimental = { ghost_text = false },
        mapping = cmp.mapping.preset.insert({
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
      })
    end,
    -- }}}
  },
}

-- vim: fdm=marker fdl=0
