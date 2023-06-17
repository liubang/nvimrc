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
        buffer                  = "BUF │",
        path                    = "PTH │",
        neorg                   = "NRG │",
        nvim_lsp                = "LSP │",
        luasnip                 = "SNP │",
        nvim_lsp_signature_help = "",
      }
      -- completion item kind abbreviations
      -- stylua: ignore
      local kind_map = { 
        Class         = " CLS",
        Color         = " CLR",
        Constant      = " CON",
        Constructor   = " CTR",
        Enum          = " ENM",
        EnumMember    = " ENM",
        Event         = " EVT",
        Field         = " FLD",
        File          = " FIL",
        Folder        = " FOL",
        Function      = " FUN",
        Interface     = " INT",
        Keyword       = " KEY",
        Method        = " MTH",
        Module        = " MOD",
        Operator      = " OPR",
        Property      = " PRP",
        Reference     = " REF",
        Snippet       = " SNP",
        Struct        = " STR",
        Text          = " TXT",
        TypeParameter = " TYP",
        Unit          = " UNT",
        Value         = " VAL",
        Variable      = " VAR",
      }
      cmp.setup {
        performance = {
          debounce = 50,
          throttle = 10,
        },
        completion = { keyword_length = 2, completeopt = "menu,menuone,preview" },
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
          completion = { border = "single", col_offset = 3 },
          documentation = false,
        },
        formatting = {
          fields = { "menu", "abbr", "kind" },
          format = function(entry, item)
            item.menu = item_map[entry.source.name] or entry.source.name
            item.abbr = vim.trim(item.abbr):sub(1, 80)
            item.kind = item.menu == "" and " " or kind_map[item.kind]
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
          ["<CR>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false },
          ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
          ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
        },
      }
    end,
    -- }}}
  },

  {
    "windwp/nvim-autopairs", -- {{{
    event = { "InsertEnter" },
    opts = function()
      require("cmp").event:on(
        "confirm_done",
        require("nvim-autopairs.completion.cmp").on_confirm_done { map_char = { tex = "" } }
      )

      return {
        check_ts = true,
        ignored_next_char = "[%w%.]",
        ts_config = {
          lua = { "string", "source" },
        },
        fast_wrap = {
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          offset = 0, -- Offset from pattern match
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "LineNr",
        },
        disable_filetype = { "TelescopePrompt", "vim" },
      }
    end,
    -- }}}
  },
}

-- vim: fdm=marker fdl=0
