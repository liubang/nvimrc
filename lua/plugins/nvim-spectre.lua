--=====================================================================
--
-- nvim-spectre.lua -
--
-- Created by liubang on 2023/11/26 16:08
-- Last Modified: 2023/11/26 16:08
--
--=====================================================================

return {
  "nvim-pack/nvim-spectre", -- {{{
  cmd = "Spectre",
  opts = { open_cmd = "noswapfile vnew" },
  keys = {
    {
      "<leader>sr",
      function()
        require("spectre").open()
      end,
      desc = "Replace in files (Spectre)",
    },
  },
  -- }}}
}
