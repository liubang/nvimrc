--=====================================================================
--
-- autocmd.lua -
--
-- Created by liubang on 2022/10/18 00:39
-- Last Modified: 2022/10/29 01:41
--
--=====================================================================

vim.filetype.add {
  filename = {
    ['BCLOUD'] = 'bzl',
    ['.bazelrc'] = 'bzl',
    ['BUILD'] = 'bzl',
    ['WORKSPACE'] = 'bzl',
    ['.gitignore'] = 'conf',
  },
  extension = {
    log = 'log',
    thrift = 'thrift',
  },
}

local filetype_commands_group = vim.api.nvim_create_augroup('FILETYPE_COMMANDS', { clear = true })
-- vim.api.nvim_create_autocmd('TextYankPost', {
--   group = filetype_commands_group,
--   desc = 'highlihgt yanking',
--   callback = function()
--     vim.highlight.on_yank { higroup = 'Substitute', timeout = 300 }
--   end,
-- })

vim.api.nvim_create_autocmd('FileType', {
  group = filetype_commands_group,
  pattern = { 'lspinfo', 'lsp-installer', 'null-ls-info', 'help', 'qf' },
  callback = function()
    local opts = { buffer = true, silent = true, desc = 'close lspinfo popup and help,qf buffers' }
    vim.keymap.set('n', 'q', function()
      vim.cmd.close()
    end, opts)
  end,
  desc = 'close lspinfo popup and help,qf buffers with q',
})

local reload_configs_group = vim.api.nvim_create_augroup('RELOAD_CONFIGS', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  group = reload_configs_group,
  pattern = '*/lua/lb/*.lua',
  callback = function(args)
    vim.notify('Reloaded ' .. args.file)
    vim.cmd.source '<afile>'
  end,
})

local special_settings_group = vim.api.nvim_create_augroup('SPECIAL_SETTINGS', { clear = true })
vim.api.nvim_create_autocmd('BufNewFile', {
  group = special_settings_group,
  callback = function()
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = 0,
      once = true,
      callback = function()
        local path = vim.fn.expand '%:h'
        local p = require('plenary.path'):new(path)
        if not p:exists() then
          p:mkdir { parents = true }
        end
      end,
      desc = 'create missing parent directories automatically',
    })
  end,
})
