--=====================================================================
--
-- pm.lua - 
--
-- Created by liubang on 2020/12/12 16:44
-- Last Modified: 2020/12/12 16:44
--
--=====================================================================

local g = vim.g
local o = vim.o
local pm = {}

local repo_path = g.cache_path .. '/dein'

pm.init_dein = function()
  if vim.fn.has('vim_starting') then
    g['dein#auto_recache'] = 0   
    g['dein#install_max_processes'] = 12
    g['dein#install_progress_type'] = 'title'
    g['dein#enable_notification'] = 1
    g['dein#install_log_filename'] = g.cache_path .. '/dein.log'
    if not o.runtimepath:match('/dein.vim') then
      local dein_dir = repo_path .. '/repos/github.com/Shougo/dein.vim'
      if not vim.fn.isdirectory(dein_dir) then
        os.execute("git clone https://github.com/Shougo/dein.vim " .. dein_dir)
      end
      o.runtimepath = o.runtimepath ..','..dein_dir
    end
  end
end

pm.load_modules = function(modules)
  if vim.fn['dein#load_state'](repo_path) == 1 then
    vim.fn['dein#begin'](repo_path, vim.fn.extend({vim.fn.expand('<sfile>')}, modules))
    -- load modules
    for _, file in pairs(modules) do
      vim.fn['dein#load_toml'](file)   
    end
    vim.fn['dein#end']()
     
    vim.fn['dein#save_state']()
    if vim.fn['dein#check_install']() == 1 then
      vim.fn['dein#install']()
    end
  end

  vim.cmd [[filetype plugin indent on]]   
  if vim.fn.has('vim_starting') then
    vim.cmd("syntax enable")
  end
  vim.fn['dein#call_hook']('source')
  vim.fn['dein#call_hook']('post_source')
end

pm.setup= function(modules)
  pm.init_dein()
  pm.load_modules(modules)
end

return pm
