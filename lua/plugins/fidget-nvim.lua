--=====================================================================
--
-- fidget-nvim.lua -
--
-- Created by liubang on 2023/11/26 16:03
-- Last Modified: 2023/11/26 16:03
--
--=====================================================================

return {
  "j-hui/fidget.nvim", -- {{{
  event = { "LspAttach" },
  opts = {
    progress = {
      ignore = { "null-ls" },
    },
    notification = {
      override_vim_notify = false,
    },
  },
  -- }}}
}
