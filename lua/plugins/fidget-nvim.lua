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
    display = {
      render_limit = 5,
      done_ttl = 2,
    },

    notification = {
      override_vim_notify = false,
    },
  },
  -- }}}
}
