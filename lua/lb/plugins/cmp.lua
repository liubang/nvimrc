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
local compare = require 'cmp.config.compare'
local luasnip = require 'luasnip'


--               ⌘  ⌂              ﲀ  練  ﴲ    ﰮ    
--       ﳤ          ƒ          了    ﬌      <    >  ⬤      襁
--                                                 
-- stylua: ignore
local kind_icons = {--{{{
  Buffers       = " ",
  Class         = " ",
  Color         = " ",
  Constant      = " ",
  Constructor   = " ",
  Enum          = " ",
  EnumMember    = " ",
  Event         = " ",
  Field         = "ﰠ ",
  File          = " ",
  Folder        = " ",
  Function      = "ƒ ",
  Interface     = " ",
  Keyword       = " ",
  Method        = " ",
  Module        = " ",
  Operator      = " ",
  Property      = " ",
  Reference     = " ",
  Snippet       = " ",
  Struct        = " ",
  TypeParameter = " ",
  Unit          = "塞",
  Value         = " ",
  Variable      = " ",
  Text          = " ",
}--}}}

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

cmp.setup {
  window = {
    documentation = false,
  },
  completion = {
    autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged },
    completeopt = 'menu,menuone,noselect',
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
    format = function(entry, vim_item)
      local client_name = ''
      if entry.source.name == 'nvim_lsp' then
        client_name = '/' .. entry.source.source.client.name
      end
      vim_item.menu = string.format('[%s%s]', ({
        buffer = 'Buffer',
        nvim_lsp = 'LSP',
        luasnip = 'LuaSnip',
        vsnip = 'VSnip',
        nvim_lua = 'Lua',
        latex_symbols = 'LaTeX',
        path = 'Path',
        rg = 'RG',
        omni = 'Omni',
        copilot = 'Copilot',
        dap = 'DAP',
        neorg = 'ORG',
      })[entry.source.name] or entry.source.name, client_name)
      vim_item.kind = string.format('%s %-9s', kind_icons[vim_item.kind], vim_item.kind)
      vim_item.dup = {
        buffer = 1,
        path = 1,
        nvim_lsp = 0,
        luasnip = 1,
      }
      return vim_item
    end,
  },
  view = {
    max_height = 20,
    entries = { name = 'custom', selection_order = 'near_cursor' },
  },
  sorting = { --{{{
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
  }, --}}}
  experimental = { ghost_text = true },
  mapping = cmp.mapping.preset.insert {
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
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
}

-- vim: fdm=marker fdl=0
