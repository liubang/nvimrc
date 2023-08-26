--=====================================================================
--
-- completion.lua -
--
-- Created by liubang on 2023/05/12 14:39
-- Last Modified: 2023/05/12 14:39
--
--=====================================================================

return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      local npairs = require('nvim-autopairs')
      npairs.setup({
        disable_filetype = { 'TelescopePrompt' },
        map_cr = false,
      })
      _G.MUtils = {}
      MUtils.completion_confirm = function()
        if vim.fn['coc#pum#visible']() ~= 0 then
          return vim.fn['coc#pum#confirm']()
        else
          return npairs.autopairs_cr()
        end
      end
      vim.keymap.set('i', '<CR>', 'v:lua.MUtils.completion_confirm()',
        { expr = true, noremap = true })
    end,
  },
  {
    'honza/vim-snippets',
    lazy = false,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. '/UltiSnips')
    end
  },
  {
    'neoclide/coc.nvim',
    branch = 'release',
    lazy = false,
    config = function()
      vim.g.coc_global_extensions = {
        'coc-dictionary',
        'coc-snippets',
        'coc-clangd',
        'coc-go',
        'coc-pyright',
        'coc-json',
        'coc-xml',
        'coc-yaml',
        'coc-markdownlint',
        'coc-marketplace',
        'coc-vimlsp',
        'coc-yank',
        'coc-prettier',
        'coc-sh',
        'coc-sumneko-lua',
        'coc-texlab',
        'coc-tsserver',
      }

      function _G.check_back_space()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
      end

      vim.cmd [[
      inoremap <silent><expr> <TAB>
          \ pumvisible() ? coc#_select_confirm() :
          \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
          \ v:lua.check_back_space() ? "\<TAB>" :
          \ coc#refresh()
      ]]
      vim.cmd [[inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]]

      -- GoTo code navigation
      vim.keymap.set('n', '<leader>gd', '<Plug>(coc-definition)', { silent = true })
      vim.keymap.set('n', '<leader>gD', '<Plug>(coc-declaration)', { silent = true })
      vim.keymap.set('n', '<leader>gy', '<Plug>(coc-type-definition)', { silent = true })
      vim.keymap.set('n', '<leader>gi', '<Plug>(coc-implementation)', { silent = true })
      vim.keymap.set('n', '<leader>gr', '<Plug>(coc-references)', { silent = true })
      vim.keymap.set('n', '<leader>rn', '<Plug>(coc-rename)', { silent = true })
      vim.keymap.set('n', '<leader>ca', '<Plug>(coc-codeaction-cursor)',
        { silent = true, nowait = true })
      vim.keymap.set('n', '<leader>as', '<Plug>(coc-codeaction-source)',
        { silent = true, nowait = true })
      vim.keymap.set('n', '<leader>qf', '<Plug>(coc-fix-current)', { silent = true, nowait = true })
      vim.keymap.set('n', '<leader>re', '<Plug>(coc-codeaction-refactor)', { silent = true })
      vim.keymap.set('n', '<leader>cl', '<Plug>(coc-codelens-action)',
        { silent = true, nowait = true })
      vim.keymap.set('n', '<leader>fm', '<Plug>(coc-format)', { silent = true })
      vim.keymap.set('n', '<leader>es', ':<C-u>CocList diagnostics<cr>', { silent = true })
      vim.keymap.set('n', '<leader>ee', '<Plug>(coc-diagnostic-info)', { silent = true })

      -- Use K to show documentation in preview window
      vim.keymap.set('n', '<c-k>', function()
        local cw = vim.fn.expand('<cword>')
        if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
          vim.api.nvim_command('h ' .. cw)
        elseif vim.api.nvim_eval('coc#rpc#ready()') then
          vim.fn.CocActionAsync('doHover')
        else
          vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
      end, { silent = true })

      -- for golang
      vim.cmd [[autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')]]
    end
  },
}

-- vim: fdm=marker fdl=0
