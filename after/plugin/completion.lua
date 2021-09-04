-- =====================================================================
--
-- completion.lua - 
--
-- Created by liubang on 2021/09/04 21:05
-- Last Modified: 2021/09/04 21:05
--
-- =====================================================================
vim.opt.completeopt = {'menuone', 'noselect'}

-- Don't show the dumb matching stuff.
vim.opt.shortmess:append 'c'

local check_back_space = function()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')

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
    ['<CR>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true}),

    ['<Tab>'] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(t('<C-n>'), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(t('<Plug>luasnip-expand-or-jump'), '')
      elseif check_back_space() then
        vim.fn.feedkeys(t('<Tab>'), 'n')
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(t('<C-p>'), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(t('<Plug>luasnip-jump-prev'), '')
      else
        fallback()
      end
    end, {'i', 's'}),

    -- These mappings are useless. I already use C-n and C-p correctly.
    -- This simply overrides them and makes them do bad things in other buffers.
    -- ["<C-p>"] = cmp.mapping.select_prev_item(),
    -- ["<C-n>"] = cmp.mapping.select_next_item(),
  },

  sources = {
    {name = 'luasnip'},
    {name = 'nvim_lua'},
    {name = 'nvim_lsp'},
    {name = 'buffer'},
    {name = 'path'},
  },
}

-- autopairs

require('nvim-autopairs').setup({disable_filetype = {'TelescopePrompt', 'vim'}})

require('nvim-autopairs.completion.cmp').setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = true, -- automatically select the first item
})
