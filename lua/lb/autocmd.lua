--=====================================================================
--
-- autocmd.lua -
--
-- Created by liubang on 2022/10/18 00:39
-- Last Modified: 2022/12/18 00:31
--
--=====================================================================

vim.filetype.add {
  filename = {
    ["BCLOUD"] = "bzl",
    [".bazelrc"] = "bzl",
    ["BUILD"] = "bzl",
    ["WORKSPACE"] = "bzl",
    [".gitignore"] = "gitconfig",
    ["go.sum"] = "gosum",
    ["go.mod"] = "gomod",
  },
  extension = {
    log = "log",
    thrift = "thrift",
    wiki = "markdown",
  },
}

local filetype_commands_group = vim.api.nvim_create_augroup("FILETYPE_COMMANDS", { clear = true })
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
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
  },
  group = filetype_commands_group,
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

local special_settings_group = vim.api.nvim_create_augroup("SPECIAL_SETTINGS", { clear = true })
vim.api.nvim_create_autocmd("BufNewFile", {
  group = special_settings_group,
  callback = function()
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = 0,
      once = true,
      callback = function()
        local path = vim.fn.expand "%:h"
        local p = require("plenary.path"):new(path)
        if not p:exists() then
          p:mkdir { parents = true }
        end
      end,
      desc = "create missing parent directories automatically",
    })
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPre", {
  pattern = "*",
  callback = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "<buffer>",
      once = true,
      callback = function()
        vim.cmd [[if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]]
      end,
    })
  end,
})

-- vim: fdm=marker fdl=0
