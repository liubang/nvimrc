--=====================================================================
--
-- nvim-colorizer.lua -
--
-- Created by liubang on 2022/12/30 21:51
-- Last Modified: 2022/12/30 21:51
--
--=====================================================================
local ft = {
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
}

return {
  "NvChad/nvim-colorizer.lua",
  ft = ft,
  opts = {
    filetypes = ft,
    r_default_options = {
      mode = "virtualtext",
      virtualtext = "■",
    },
  },
}

-- vim: fdm=marker fdl=0
