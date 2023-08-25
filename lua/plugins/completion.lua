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
        'coc-markdownlint',
        'coc-marketplace',
        'coc-pairs',
        'coc-vimlsp',
        'coc-yank',
        'coc-prettier',
        'coc-sh',
        'coc-sumneko-lua',
        'coc-texlab',
        'coc-tsserver',
        'coc-sql',
      }

      local keyset = vim.keymap.set
      -- Autocomplete
      function _G.check_back_space()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
      end

      local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
      keyset('i', '<TAB>',
        'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
        opts)
      keyset('i', '<S-TAB>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

      keyset('i', '<cr>',
        [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
      keyset('i', '<c-j>', '<Plug>(coc-snippets-expand-jump)')

      -- GoTo code navigation
      keyset('n', '<leader>gd', '<Plug>(coc-definition)', { silent = true })
      keyset('n', '<leader>gD', '<Plug>(coc-declaration)', { silent = true })
      keyset('n', '<leader>gy', '<Plug>(coc-type-definition)', { silent = true })
      keyset('n', '<leader>gi', '<Plug>(coc-implementation)', { silent = true })
      keyset('n', '<leader>gr', '<Plug>(coc-references)', { silent = true })
      keyset('n', '<leader>rn', '<Plug>(coc-rename)', { silent = true })
      keyset('n', '<leader>ca', '<Plug>(coc-codeaction-cursor)', { silent = true, nowait = true })
      keyset('n', '<leader>as', '<Plug>(coc-codeaction-source)', { silent = true, nowait = true })
      keyset('n', '<leader>qf', '<Plug>(coc-fix-current)', { silent = true, nowait = true })
      keyset('n', '<leader>re', '<Plug>(coc-codeaction-refactor)', { silent = true })
      keyset('n', '<leader>cl', '<Plug>(coc-codelens-action)', { silent = true, nowait = true })
      keyset('n', '<leader>fm', '<Plug>(coc-format)', { silent = true })
      keyset('n', '<leader>es', ':<C-u>CocList diagnostics<cr>', { silent = true })
      keyset('n', '<leader>ee', '<Plug>(coc-diagnostic-info)', { silent = true })

      -- Use K to show documentation in preview window
      keyset('n', '<c-k>', function()
        local cw = vim.fn.expand('<cword>')
        if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
          vim.api.nvim_command('h ' .. cw)
        elseif vim.api.nvim_eval('coc#rpc#ready()') then
          vim.fn.CocActionAsync('doHover')
        else
          vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
      end, { silent = true })
      -- Add `:OR` command for organize imports of the current buffer
      vim.api.nvim_create_user_command('OrgImports',
        "call CocActionAsync('runCommand', 'editor.action.organizeImport')",
        {})
    end
  },
}

-- vim: fdm=marker fdl=0
