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
      -- vim.cmd.packadd "lspkind.nvim"
      local lspkind = require "lspkind"

      -- stylua: ignore
      lspkind.init {
        preset = "codicons",
        symbol_map = {
          NONE          = "",
          Array         = "",
          Boolean       = "⊨",
          Class         = "",
          Constructor   = "",
          Key           = "",
          Namespace     = "",
          Null          = "NULL",
          Number        = "#",
          Object        = "⦿",
          Package       = "",
          Property      = "",
          Reference     = "",
          Snippet       = "",
          String        = "𝓐",
          TypeParameter = "",
          Unit          = "",
        },
      }

      local cmp = require "cmp"

      cmp.setup {
        performance = {
          debounce = 50,
          throttle = 10,
        },
        window = {
          documentation = false,
          completion = cmp.config.window.bordered {
            border = "none",
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
          },
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
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
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind = lspkind.cmp_format {
              mode = "symbol_text",
              maxwidth = 80,
            }(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. strings[1] .. " "
            kind.menu = "    (" .. strings[2] .. ")"
            return kind
          end,
        },
        view = {
          max_height = 20,
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        experimental = {
          ghost_text = false,
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm { select = true },
          ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
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
