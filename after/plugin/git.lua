-- =====================================================================
--
-- git.lua -
--
-- Created by liubang on 2021/08/29 03:52
-- Last Modified: 2021/08/29 03:52
--
-- =====================================================================

require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '▋' },
    change = { hl = 'GitGutterChange', text = '▋' },
    delete = { hl = 'GitGutterDelete', text = '▋' },
    topdelete = { hl = 'GitGutterDeleteChange', text = '▔' },
    changedelete = { hl = 'GitGutterChange', text = '▎' },
  },
  watch_gitdir = { interval = 1000, follow_files = true },
  current_line_blame = true,
  current_line_blame_opts = { delay = 1000, virtual_text_pos = 'eol' },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  word_diff = false,
  diff_opts = { internal = true },
}
