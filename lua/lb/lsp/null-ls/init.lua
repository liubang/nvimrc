--=====================================================================
--
-- init.lua -
--
-- Created by liubang on 2022/02/25 14:54
-- Last Modified: 2022/02/25 14:54
--
--=====================================================================
local null_ls = require 'null-ls'

require('null-ls').setup {
  on_attach = require('lb.lsp.customs').default({}).on_attach,
  sources = {
    require 'lb.lsp.null-ls.formatting.buildifier',
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.asmfmt,
    null_ls.builtins.formatting.shfmt.with {
      extra_args = { '-i', '2', '-ci' },
    },
    null_ls.builtins.formatting.prettier.with {
      filetypes = { 'json', 'yaml', 'markdown' },
    },
  },
}
