-- =====================================================================
--
-- completion.lua -
--
-- Created by liubang on 2021/09/04 21:05
-- Last Modified: 2021/09/04 21:05
--
-- =====================================================================

vim.cmd [[packadd lspkind.nvim]]

local cmp = require 'cmp'
local compare = require 'cmp.config.compare'
local lspkind = require 'lspkind'

lspkind.init()

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
-- Don't show the dumb matching stuff.
vim.opt.shortmess:append 'c'

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

cmp.setup {
  window = {
    documentation = false,
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  preselect = cmp.PreselectMode.None,
  sources = {
    { name = 'nvim_lua', priority = 80 },
    { name = 'nvim_lsp', priority = 80 },
    { name = 'luasnip', priority = 10 },
    { name = 'path', priority = 40, max_item_count = 4 },
    {
      name = 'buffer',
      priority = 5,
      keywork_length = 3,
      max_item_count = 5,
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
    { name = 'calc' },
  },
  formatting = {
    format = lspkind.cmp_format {
      mode = 'symbol',
      maxwidth = 80,
      ellipsis_char = '...',
      menu = {
        buffer = '[BUF]',
        nvim_lsp = '[LSP]',
        nvim_lua = '[API]',
        path = '[PATH]',
        luasnip = '[SNIP]',
      },
    },
  },
  view = {
    max_height = 20,
    entries = { name = 'native', selection_order = 'near_cursor' },
  },
  sorting = {
    comparators = {
      function(...)
        return require('cmp_buffer'):compare_locality(...)
      end,
      compare.offset,
      compare.exact,
      compare.score,
      compare.recently_used,
      compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
    },
  },
  experimental = {
    ghost_text = true,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require('luasnip').expand_or_jumpable() then
        vim.fn.feedkeys(t '<Plug>luasnip-expand-or-jump', '')
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
      elseif require('luasnip').jumpable(-1) then
        vim.fn.feedkeys(t '<Plug>luasnip-jump-prev', '')
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
  },
}

for _, v in pairs { '/', '?' } do
  cmp.setup.cmdline(v, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'fuzzy_buffer', max_item_count = 15 },
    },
  })
end

-- vim: fdm=marker fdl=0
