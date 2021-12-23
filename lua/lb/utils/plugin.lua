--=====================================================================
--
-- plugin.lua -
--
-- Created by liubang on 2021/12/08 18:58
-- Last Modified: 2021/12/08 18:58
--
--=====================================================================

local M = {}

function M.packer_notify(msg, level)
  vim.notify(msg, level, { title = 'Packer' })
end

function M.conf(name)
  return require(string.format('lb.plugin.%s', name))
end

function M.bootstrap_packer()
  local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    M.packer_notify 'Downloading packer.nvim...'
    M.packer_notify(vim.fn.system {
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path,
    })
    vim.cmd [[packadd packer.nvim]]
    return true
  else
    return false
  end
end

return M
