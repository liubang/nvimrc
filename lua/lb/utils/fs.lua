-- =====================================================================
--
-- fs.lua - 
--
-- Created by liubang on 2020/12/20 20:27
-- Last Modified: 2020/12/20 20:27
--
-- =====================================================================
local fs = {}

fs.list_files = function(path, filter)
  local p = assert(io.popen('find "' .. path .. '" -name "' .. filter .. '"'))
  local files = {}
  for file in p:lines() do
    table.insert(files, file)
  end
  return files
end

fs.file_size = function(file)
  local size = vim.fn.getfsize(file)
  if size == 0 or size == -1 or size == -2 then
    return '0B'
  end
  if size < 1024 then
    return size .. 'B'
  elseif size < 1024 * 1024 then
    return string.format('%.1fKB', size / 1024)
  elseif size < 1024 * 1024 * 1024 then
    return string.format('%.1fMB', size / 1024 / 1024)
  else
    return string.format('%.1fGB', size / 1024 / 1024 / 1024)
  end
end

return fs
