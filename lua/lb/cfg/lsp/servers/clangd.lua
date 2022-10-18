--=====================================================================
--
-- clangd.lua -
--
-- Created by liubang on 2022/08/06 00:17
-- Last Modified: 2022/08/06 00:17
--
--=====================================================================

local c = require 'lb.cfg.lsp.customs'
local lspconfig = require 'lspconfig'
local Job = require 'plenary.job'

local get_default_driver = function()
  local gcc = Job:new { command = 'which', args = { 'g++' } }
  local llvm = Job:new { command = 'which', args = { 'clang++' } }
  local _, result = pcall(function()
    local gcct = gcc:sync()
    local llvmt = llvm:sync()
    if #gcct > 0 then
      return vim.trim(gcct[1])
    end
    if #llvmt > 0 then
      return vim.trim(llvmt[1])
    end
    return nil
  end)
  return result
end

local setup = function()
  lspconfig.clangd.setup(c.default {
    cmd = {
      'clangd',
      '--background-index',
      '-j=4',
      '--suggest-missing-includes',
      '--function-arg-placeholders',
      '--clang-tidy',
      '--header-insertion=never',
      '--completion-style=detailed',
      '--query-driver=' .. get_default_driver(),
      '--offset-encoding=utf-32',
      '--enable-config',
      '--fallback-style=google',
    },
    init_options = {
      clangdFileStatus = true,
    },
  })
end

return {
  setup = setup,
}
