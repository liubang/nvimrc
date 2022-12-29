return {
  {
    "NvChad/nvim-colorizer.lua",
    ft = {
      "css",
      "scss",
      "sass",
      "html",
      "lua",
      "vim",
      "markdown",
      "javascript",
      "typescript",
      "typescriptreact",
      "javascriptreact",
    },
    config = function()
      require("colorizer").setup {
        filetypes = {
          "css",
          "scss",
          "sass",
          "html",
          "lua",
          "vim",
          "markdown",
          "javascript",
          "typescript",
          "typescriptreact",
          "javascriptreact",
        },
        r_default_options = {
          mode = "virtualtext",
          virtualtext = "■",
        },
      }
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
}
