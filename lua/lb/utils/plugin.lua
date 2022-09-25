--=====================================================================
--
-- plugin.lua -
--
-- Created by liubang on 2021/12/08 18:58
-- Last Modified: 2021/12/08 18:58
--
--=====================================================================

local M = {}

M.bootstrap_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system {
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path,
    }
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

return M
