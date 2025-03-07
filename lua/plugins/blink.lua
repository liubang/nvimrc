return {
  "saghen/blink.cmp",
  version = "*",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
    { "L3MON4D3/LuaSnip", version = "v2.*" },
  },
  opts_extend = { "sources.default" },
  opts = {
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    completion = {
      documentation = { auto_show = false },
      menu = {
        draw = { treesitter = { "lsp" } },
      },
    },
    cmdline = { enabled = false },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = {
      enabled = false,
      window = { show_documentation = false },
    },
    keymap = {
      preset = "enter",
      ["<Up>"] = {},
      ["<Down>"] = {},
      ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
      ["<C-j>"] = { "select_next", "fallback_to_mappings" },
    },
  },
}
