-- =====================================================================
--
-- buffer.lua -
--
-- Created by liubang on 2021/01/15 15:05
-- Last Modified: 2021/01/15 15:05
--
-- =====================================================================
local api, fn = vim.api, vim.fn
local special_buffers = {
  'qf',
  'git',
  'help',
  'term',
  'plug',
  'defx',
  'vista',
  'vista_kind',
  'help',
  'packer',
  'undotree',
  'startify',
  'vim-plug',
  'NvimTree',
  'Mundo',
  'MundoDiff',
  'fugitive',
  'fugitiveblame',
  'startuptime',
  'SpaceVimPlugManager',
}

local list_special_buffers = function()
  return special_buffers
end

local is_special_buffer = function()
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

local check_back_space = function()
  local col = fn.col '.' - 1
  return col == 0 or fn.getline('.'):sub(col, col):match '%s' ~= nil
end

return {
  is_special_buffer = is_special_buffer,
  check_back_space = check_back_space,
  list_special_buffers = list_special_buffers,
}
