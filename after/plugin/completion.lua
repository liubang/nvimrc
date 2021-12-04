-- =====================================================================
--
-- completion.lua -
--
-- Created by liubang on 2021/09/04 21:05
-- Last Modified: 2021/09/04 21:05
--
-- =====================================================================
vim.opt.completeopt = { 'menuone', 'noselect' }

-- Don't show the dumb matching stuff.
vim.opt.shortmess:append 'c'

local cmp = require 'cmp'
local lspkind = require 'lspkind'
local luasnip = require 'luasnip'
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

lspkind.init()

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = '[buffer]',
        path = '[path]',
        nvim_lsp = '[lsp]',
        luasnip = '[snip]',
        nvim_lua = '[lua]',
        latex_symbols = '[latex]',
      },
    },
  },
  documentation = false,
  mapping = {
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
  },

  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'calc' },
  },
  experimental = {
    native_menu = false,
  },
}

-- autopairs
require('nvim-autopairs').setup { disable_filetype = { 'TelescopePrompt', 'vim' } }
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done { map_char = { tex = '' } })
