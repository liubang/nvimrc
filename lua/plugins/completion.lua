--=====================================================================
--
-- completion.lua -
--
-- Created by liubang on 2023/05/12 14:39
-- Last Modified: 2023/05/12 14:39
--
--=====================================================================

return {
  {
    "hrsh7th/nvim-cmp", -- {{{
    version = false,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "saadparwaiz1/cmp_luasnip",
      "kdheepak/cmp-latex-symbols",
    },
    event = { "InsertEnter" },
    config = function()
      local cmp = require "cmp"
      -- completion item source name abbreviations
      -- stylua: ignore
      local item_map = {
        buffer                  = "BUF",
        path                    = "PTH",
        neorg                   = "NRG",
        nvim_lsp                = "LSP",
        luasnip                 = "SNP",
        nvim_lsp_signature_help = "",
      }
      -- completion item kind abbreviations
      -- stylua: ignore
      local kind_icons = {
        Text          = "",
        Method        = "",
        Function      = "",
        Constructor   = "",
        Field         = "",
        Variable      = "",
        Class         = "",
        Interface     = "",
        Module        = "",
        Property      = "",
        Unit          = "",
        Value         = "",
        Enum          = "",
        Keyword       = "",
        Snippet       = "",
        Color         = "",
        File          = "",
        Reference     = "",
        Folder        = "",
        EnumMember    = "",
        Constant      = "",
        Struct        = "",
        Event         = "",
        Operator      = "",
        TypeParameter = "",
      }
      cmp.setup {
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
          { name = "path", priority = 40, max_item_count = 4 },
          {
            name = "buffer",
            priority = 5,
            keywork_length = 3,
            max_item_count = 5,
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end,
            },
          },
          { name = "crates" },
          { name = "latex_symbols" },
          { name = "calc" },
        },
        window = {
          documentation = false,
          winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
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
            -- item.menu = item_map[entry.source.name] or entry.source.name
            item.kind = string.format("%s  %-9s", kind_icons[item.kind], item.kind)
            return item
          end,
        },
        view = { max_height = 20 },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        experimental = { ghost_text = false },
        mapping = cmp.mapping.preset.insert {
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm { select = true },
          ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
          ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
        },
      }
    end,
    -- }}}
  },

  -- auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      disable_filetype = { "TelescopePrompt" },
    },
  },
}

-- vim: fdm=marker fdl=0
