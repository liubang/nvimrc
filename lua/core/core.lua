--=====================================================================
--
-- core.lua - 
--
-- Created by liubang on 2020/12/11
-- Last Modified: 2020/12/11 00:23
--
--=====================================================================

local M = {}

M.init = function() 
  vim.cmd [[filetype off]]
  vim.cmd [[augroup vimrc]]
  vim.cmd [[  autocmd!]]
  vim.cmd [[augroup END]]
end

M.run = function(root)
  M.init()

  vim.g.nvg_version = 'v2.2'
  vim.g.nvg_root = root
  vim.api.nvim_set_var('dein#inline_vimrcs', {
    root .. '/configs/general.vim',
    root .. '/configs/mappings.vim',
    root .. '/configs/autocmds.vim'
  })

  vim.fn['pm#_start']()
end

return M
