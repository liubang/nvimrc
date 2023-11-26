--=====================================================================
--
-- vim-illuminate.lua -
--
-- Created by liubang on 2023/11/26 15:37
-- Last Modified: 2023/11/26 15:37
--
--=====================================================================

return {
  "RRethy/vim-illuminate", -- {{{
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    delay = 200,
    under_cursor = true,
    providers = { "lsp" },
    filetypes_denylist = {
      "neo-tree",
      "DoomInfo",
      "DressingSelect",
      "NvimTree",
      "TelescopePrompt",
      "Trouble",
      "aerial",
      "alpha",
      "dashboard",
      "dirvish",
      "fugitive",
      "help",
      "neogitstatus",
      "norg",
      "toggleterm",
    },
  },
  config = function(_, opts)
    require("illuminate").configure(opts)

    local function map(key, dir, buffer)
      vim.keymap.set("n", key, function()
        require("illuminate")["goto_" .. dir .. "_reference"](false)
      end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
    end

    map("]]", "next")
    map("[[", "prev")

    -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        local buffer = vim.api.nvim_get_current_buf()
        map("]]", "next", buffer)
        map("[[", "prev", buffer)
      end,
    })
  end,
  keys = {
    { "]]", desc = "Next Reference" },
    { "[[", desc = "Prev Reference" },
  },
  -- }}}
}
