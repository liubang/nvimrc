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
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

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
    format = function(entry, vim_item)
      -- fancy icons and a name of kind
      vim_item.kind = lspkind.presets.default[vim_item.kind] .. ' ' .. vim_item.kind

      -- set a name for each source
      vim_item.menu = ({
        buffer = '[buffer]',
        path = '[path]',
        nvim_lsp = '[lsp]',
        luasnip = '[snip]',
        nvim_lua = '[lua]',
        latex_symbols = '[latex]',
      })[entry.source.name]

      return vim_item
    end,
  },

  documentation = false,

  mapping = {
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
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
}

cmp.setup.cmdline(':', {
    completion = {
      autocomplete = false,
    },
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { 
        name = 'cmdline',
        max_item_count = 20,
        keyword_length = 4,
      }
    })
})

cmp.setup.cmdline('/', {
    completion = {
      autocomplete = false,
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp_document_symbol' }
    }, {
      { name = 'buffer' }
    })
})

-- autopairs
require('nvim-autopairs').setup { disable_filetype = { 'TelescopePrompt', 'vim' } }
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
