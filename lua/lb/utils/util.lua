--=====================================================================
--
-- util.lua -
--
-- Created by liubang on 2022/09/04 17:33
-- Last Modified: 2022/12/04 04:37
--
--=====================================================================

local M = {}
local is_windows = vim.loop.os_uname().version:match "Windows"

math.randomseed(os.time())

M.uuid = function() --{{{
  local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
  local out
  local function subs(c)
    local v = (((c == "x") and math.random(0, 15)) or math.random(8, 11))
    return string.format("%x", v)
  end
  out = template:gsub("[xy]", subs)
  return out
end --}}}

local charset = {} -- Random String {{{
for i = 48, 57 do
  table.insert(charset, string.char(i))
end
for i = 65, 90 do
  table.insert(charset, string.char(i))
end
for i = 97, 122 do
  table.insert(charset, string.char(i))
end
M.random_string = function(length)
  if length == 0 then
    return ""
  end
  return M.random_string(length - 1) .. charset[math.random(1, #charset)]
end --}}}

---Runs the command in shell.
-- @param command string
-- @return table
M.shell = function(command) --{{{
  local file = io.popen(command, "r")
  local res = {}
  if file ~= nil then
    for line in file:lines() do
      table.insert(res, line)
    end
  end
  return res
end --}}}

M.sep = function()
  if is_windows then
    return "\\"
  end
  return "/"
end

M.rel_path = function(folder)
  local mod = "%:p"
  if folder then
    mod = "%:p:h"
  end
  local fpath = vim.fn.expand(mod)
  local workfolders = vim.lsp.buf.list_workspace_folders()
  if vim.fn.empty(workfolders) == 0 then
    fpath = "." .. fpath:sub(#workfolders[1] + 1)
  else
    fpath = vim.fn.fnamemodify(vim.fn.expand(mod), ":p:.")
  end
  if fpath:sub(#fpath) == M.sep() then
    fpath = fpath:sub(1, #fpath - 1)
  end
  return fpath
end

M.trim_whitespace = function()
  if not vim.bo.modifiable or vim.bo.binary or vim.bo.filetype == "diff" then
    return
  end
  local ok, val = pcall(vim.api.nvim_buf_get_var, 0, "DISABLE_TRIM_WHITESPACES")
  if ok and val then
    return
  end
  local cursor = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_command [[keeppatterns %s/\s\+$//e]]
  vim.api.nvim_command [[silent! %s#\($\n\s*\)\+\%$##]]
  vim.api.nvim_win_set_cursor(0, cursor)
end

M.rtrim = function(s)
  local n = #s
  while n > 0 and s:find("^%s", n) do
    n = n - 1
  end
  return s:sub(1, n)
end

M.ltrim = function(s)
  return (s:gsub("^%s*", ""))
end

M.trim = function(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- @Ref https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/util.lua
M.path = (function()
  local function escape_wildcards(path)
    return path:gsub("([%[%]%?%*])", "\\%1")
  end

  local function sanitize(path)
    if is_windows then
      path = path:sub(1, 1):upper() .. path:sub(2)
      path = path:gsub("\\", "/")
    end
    return path
  end

  local function exists(filename)
    local stat = vim.loop.fs_stat(filename)
    return stat and stat.type or false
  end

  local function is_dir(filename)
    return exists(filename) == "directory"
  end

  local function is_file(filename)
    return exists(filename) == "file"
  end

  local function is_fs_root(path)
    if is_windows then
      return path:match "^%a:$"
    else
      return path == "/"
    end
  end

  local function is_absolute(filename)
    if is_windows then
      return filename:match "^%a:" or filename:match "^\\\\"
    else
      return filename:match "^/"
    end
  end

  local function dirname(path)
    local strip_dir_pat = "/([^/]+)$"
    local strip_sep_pat = "/$"
    if not path or #path == 0 then
      return
    end
    local result = path:gsub(strip_sep_pat, ""):gsub(strip_dir_pat, "")
    if #result == 0 then
      if is_windows then
        return path:sub(1, 2):upper()
      else
        return "/"
      end
    end
    return result
  end

  local function path_join(...)
    return table.concat(vim.tbl_flatten { ... }, "/")
  end

  -- Traverse the path calling cb along the way.
  local function traverse_parents(path, cb)
    path = vim.loop.fs_realpath(path)
    local dir = path
    -- Just in case our algo is buggy, don't infinite loop.
    for _ = 1, 100 do
      dir = dirname(dir)
      if not dir then
        return
      end
      -- If we can't ascend further, then stop looking.
      if cb(dir, path) then
        return dir, path
      end
      if is_fs_root(dir) then
        break
      end
    end
  end

  -- Iterate the path until we find the rootdir.
  local function iterate_parents(path)
    local function it(_, v)
      if v and not is_fs_root(v) then
        v = dirname(v)
      else
        return
      end
      if v and vim.loop.fs_realpath(v) then
        return v, path
      else
        return
      end
    end
    return it, path, path
  end

  local function is_descendant(root, path)
    if not path then
      return false
    end

    local function cb(dir, _)
      return dir == root
    end

    local dir, _ = traverse_parents(path, cb)

    return dir == root
  end

  local path_separator = is_windows and ";" or ":"

  return {
    escape_wildcards = escape_wildcards,
    is_dir = is_dir,
    is_file = is_file,
    is_absolute = is_absolute,
    exists = exists,
    dirname = dirname,
    join = path_join,
    sanitize = sanitize,
    traverse_parents = traverse_parents,
    iterate_parents = iterate_parents,
    is_descendant = is_descendant,
    path_separator = path_separator,
  }
end)()

function M.root_pattern(...)
  local patterns = vim.tbl_flatten { ... }
  local function matcher(path)
    for _, pattern in ipairs(patterns) do
      for _, p in ipairs(vim.fn.glob(M.path.join(M.path.escape_wildcards(path), pattern), true, true)) do
        if M.path.exists(p) then
          return path
        end
      end
    end
  end
  return function(startpath)
    startpath = M.strip_archive_subpath(startpath)
    return M.search_ancestors(startpath, matcher)
  end
end

function M.search_ancestors(startpath, func)
  vim.validate { func = { func, "f" } }
  if func(startpath) then
    return startpath
  end
  local guard = 100
  for path in M.path.iterate_parents(startpath) do
    -- Prevent infinite recursion if our algorithm breaks
    guard = guard - 1
    if guard == 0 then
      return
    end

    if func(path) then
      return path
    end
  end
end

-- For zipfile: or tarfile: virtual paths, returns the path to the archive.
-- Other paths are returned unaltered.
function M.strip_archive_subpath(path)
  -- Matches regex from zip.vim / tar.vim
  path = vim.fn.substitute(path, "zipfile://\\(.\\{-}\\)::[^\\\\].*$", "\\1", "")
  path = vim.fn.substitute(path, "tarfile:\\(.\\{-}\\)::.*$", "\\1", "")
  return path
end

return M
