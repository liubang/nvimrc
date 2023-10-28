--=====================================================================
--
-- autocmd.lua -
--
-- Created by liubang on 2022/10/18 00:39
-- Last Modified: 2022/12/31 22:28
--
--=====================================================================

local filetype_commands_group = vim.api.nvim_create_augroup("FILETYPE_COMMANDS", { clear = true })

-- close lspinfo popup and help,qf buffers with q {{{
vim.api.nvim_create_autocmd("FileType", {
  group = filetype_commands_group,
  pattern = { "lspinfo", "lsp-installer", "null-ls-info", "help", "qf" },
  callback = function()
    local opts = { buffer = true, silent = true, desc = "close lspinfo popup and help,qf buffers" }
    vim.keymap.set("n", "q", function()
      vim.cmd.close()
    end, opts)
  end,
  desc = "close lspinfo popup and help,qf buffers with q",
}) -- }}}

local special_settings_group = vim.api.nvim_create_augroup("SPECIAL_SETTINGS", { clear = true })

-- create missing parent directories automatically {{{
vim.api.nvim_create_autocmd("BufNewFile", {
  group = special_settings_group,
  callback = function()
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = 0,
      once = true,
      callback = function()
        local path = vim.fn.expand("%:h")
        local p = require("plenary.path"):new(path)
        if not p:exists() then
          p:mkdir({ parents = true })
        end
      end,
      desc = "create missing parent directories automatically",
    })
  end,
}) -- }}}

-- go to last loc when opening a buffer {{{
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
}) -- }}}

-- vim: fdm=marker fdl=0
