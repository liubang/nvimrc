--=====================================================================
--
-- nvim-spectre.lua -
--
-- Created by liubang on 2023/04/01 12:23
-- Last Modified: 2023/04/01 12:23
--
--=====================================================================
return {
  "windwp/nvim-spectre",
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
}
