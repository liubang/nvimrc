-- =====================================================================
--
-- init.lua -
--
-- Created by liubang on 2020/12/11
-- Last Modified: 2020/12/11 00:23
--
-- =====================================================================
local g, fn, api = vim.g, vim.fn, vim.api
local app = {}
local special_buffers = {
  'git',
  'defx',
  'vista',
  'undotree',
  'help',
  'startify',
  'SpaceVimPlugManager',
  'vim-plug',
  'NvimTree',
  'Mundo',
  'MundoDiff',
}

P = function(v)
  print(vim.inspect(v))
  return v
end

_G.folds_render = require('lb.utils.folds').render

_G.is_special_buffer = function()
  local buftype = api.nvim_buf_get_option(0, 'buftype')
  if buftype == 'terminal' or buftype == 'quickfix' or buftype == 'help' then
    return true
  end
  local filetype = api.nvim_buf_get_option(0, 'filetype')
  for _, b in ipairs(special_buffers) do
    if filetype == b then
      return true
    end
  end
  return false
end

_G.check_back_space = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

function string:split(sep)
  local sep, fields = sep or ':', {}
  local pattern = string.format('([^%s]+)', sep)
  self:gsub(pattern, function(c)
    fields[#fields + 1] = c
  end)
  return fields
end

app.run = function(v)
  -- LuaFormatter off
  g.nvg_version = v
  g.nvg_root    = fn.stdpath('config')
  g.cache_path  = string.format('%s/.cache', g.nvg_root)
  g.module_path = string.format('%s/modules', g.nvg_root)
  g.snip_path   = string.format('%s/snippets', g.nvg_root)

  -- plugins
  -- require('lb.plugins')
  require('lb.utils.pm').setup(
    require('lb.utils.fs').list_files(g.module_path, '*.toml')
  )
  -- LuaFormatter on
  require('lb.options')
  require('lb.mappings')
  require('lb.events')
  require('lb.commands')
end

return app
