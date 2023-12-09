--=====================================================================
--
-- init.lua -
--
-- Created by liubang on 2021/11/30 22:45
-- Last Modified: 2022/12/31 22:32
--
--=====================================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lb.options") -- global options

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("lb.bootstrap").lazy(lazypath)
end

vim.opt.rtp:prepend(lazypath)

require("lb.plugins")
require("lb.autocmd")
require("lb.commands")
require("lb.mappings")

-- vim: fdm=marker fdl=0
