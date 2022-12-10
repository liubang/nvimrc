--=====================================================================
--
-- installer.lua -
--
-- Created by liubang on 2022/12/10 19:31
-- Last Modified: 2022/12/10 19:31
--
--=====================================================================
local Job = require "plenary.job"

local urls = {
  gomodifytags = "github.com/fatih/gomodifytags",
  impl = "github.com/josharian/impl",
  fillstruct = "github.com/davidrjenni/reftools/cmd/fillstruct",
  mockgen = "github.com/golang/mock/mockgen",
}

local installer = {}
-- notify title
local title = { title = "GoInstaller" }

local is_installed = function(bin_name)
  return vim.fn.executable(bin_name) == 1
end

local install_pkg = function(bin_name)
  local url = urls[bin_name]
  if url == nil then
    vim.notify("command " .. bin_name .. " not supported", vim.log.levels.ERROR, title)
    return
  end

  -- get the neweast version
  url = url .. "@latest"

  local j = Job:new {
    command = "go",
    args = { "install", url },
  }
  -- timeout 60s
  j:sync(60000)

  if j.code ~= 0 then
    local err = j:stderr_result()
    if type(err) == "table" then
      err = table.concat(err, "\n")
    end
    vim.notify("Failed to install " .. url .. " the result is\n" .. err, vim.log.levels.ERROR, title)
    return
  end
  vim.notify("Install " .. url .. " success", vim.log.levels.INFO, title)
end

installer.install = function(bin_name)
  if is_installed(bin_name) then
    vim.notify(bin_name .. " already been installed", vim.log.levels.INFO, title)
    return
  end

  install_pkg(bin_name)
end

installer.update = function(bin_name)
  install_pkg(bin_name)
end

installer.install_all = function()
  for bin, _ in pairs(urls) do
    installer.install(bin)
  end
end

installer.update_all = function()
  for bin, _ in pairs(urls) do
    installer.update(bin)
  end
end

return installer
