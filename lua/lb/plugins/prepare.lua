-- =====================================================================
--
-- packer.lua - 
--
-- Created by liubang on 2021/04/19 10:56
-- Last Modified: 2021/04/19 10:56
--
-- =====================================================================
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])
if not packer_exists then
  if vim.fn.input('Download Packer? (y for yes)') ~= 'y' then
    return
  end
  local directory = string.format('%s/site/pack/packer/opt/',
                                  vim.fn.stdpath('data'))
  vim.fn.mkdir(directory, 'p')
  local out = vim.fn.system(string.format('git clone %s %s',
                                          'https://github.com/wbthomason/packer.nvim',
                                          directory .. '/packer.nvim'))
  print(out)
  print('Downloading packer.nvim...')
  return
end
