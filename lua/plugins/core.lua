--=====================================================================
--
-- init.lua -
--
-- Created by liubang on 2022/12/30 22:29
-- Last Modified: 2022/12/30 22:29
--
--=====================================================================
return {
  { "folke/lazy.nvim", version = "*" },
  "nvim-lua/plenary.nvim",
  "onsails/lspkind.nvim",
  "nvim-tree/nvim-web-devicons",
  "williamboman/mason-lspconfig.nvim",
  "MunifTanjim/nui.nvim",
  {
    "famiu/bufdelete.nvim",
    cmd = { "Bdelete", "Bwipeout" },
    keys = {
      { "<Leader>bd", "<CMD>Bwipeout<CR>", mode = { "n" } },
    },
  },
  { "dstein64/vim-startuptime", cmd = "StartupTime" },
}

-- vim: fdm=marker fdl=0
