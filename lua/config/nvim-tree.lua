--=====================================================================
--
-- nvim-tree.lua - 
--
-- Created by liubang on 2020/12/11
-- Last Modified: 2020/12/11 00:23
--
--=====================================================================

local M = {}

local buf_mapper = function(mode, key, result) 
  vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua " .. result .. "<CR>", {noremap = true, silent = true})
end

M.tree_config = function()
  vim.g.lua_tree_hide_dotfiles = 1
end

M.tree_context_menu = function()
  local actions = {"create", "rename", "copy", "cut", "paste", "remove"}
  local section = vim.fn.confirm('Action?', "&New file/directory\n&Rename\n&Copy\n&Move\n&Paste\n&Delete")  
  vim.cmd('redraw')  
  require("tree").on_keypress(actions[section])
end

M.tree_mapping = function()
  buf_mapper('n', 'm', 'require("config.nvim-tree").tree_context_menu()')
  buf_mapper('n', 'r', 'require("tree").on_keypress("refresh")')
  buf_mapper('n', 's', 'require("tree").on_keypress("split")')
  buf_mapper('n', 'v', 'require("tree").on_keypress("vsplit")')
end

M.tree_autocmd = function()
  vim.cmd [[augroup LuaTree]]
  vim.cmd [[ au!]]
  vim.cmd [[ autocmd FileType LuaTree :lua require('config.nvim-tree').tree_mapping() ]]
  vim.cmd [[augroup END]]
end

M.on_attach = function()
  M.tree_config()
  M.tree_autocmd() 
end

return M
