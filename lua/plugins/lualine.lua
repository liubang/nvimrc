--=====================================================================
--
-- lualine.lua -
--
-- Created by liubang on 2022/12/30 23:34
-- Last Modified: 2023/02/19 00:39
--
--=====================================================================

local M = { "nvim-lualine/lualine.nvim", event = "VeryLazy" }

function M.config()
  local lualine = require "lualine"

  local lineinfo = function()
    local line = vim.fn.line "."
    local column = vim.fn.col "."
    return string.format("%d:%d %s", line, column, "[%p%%]")
  end

  local filesize = function()
    local file = vim.fn.expand "%:p"
    if file == nil or #file == 0 then
      return ""
    end
    local size = vim.fn.getfsize(file)
    if size <= 0 then
      return ""
    end

    local suffixes = { "B", "KB", "MB", "GB" }

    local i = 1
    while size > 1024 and i < #suffixes do
      size = size / 1024
      i = i + 1
    end

    local format = i == 1 and "[%d%s]" or "[%.1f%s]"
    return string.format(format, size, suffixes[i])
  end

  local mode = function()
    return "\u{e7c5} " .. require("lualine.utils.mode").get_mode()
  end

  -- stylua: ignore start
  local lsp_names = { --{{{
    ["null-ls"]             = "NLS",
    ["diagnostics_on_open"] = "Diagnostics",
    ["diagnostics_on_save"] = "Diagnostics",
    clangd                  = "C++",
    gopls                   = "Go",
    rust_analyzer           = "Rust",
    lua_ls                  = "Lua",
    intelephense            = "PHP",
    pyright                 = "Python",
    bashls                  = "Bash",
    dockerls                = "Docker",
    tsserver                = "TS",
    jsonls                  = "JSON",
    sqls                    = "SQL",
    texlab                  = "LaTeX",
    taplo                   = "TOML",
    html                    = "HTML",
    vimls                   = "Vim",
    yamlls                  = "YAML",
    cssls                   = "CSS",
    emmet_ls                = "EMMET",
    jdtls                   = "Java",
  }
  --}}}
  -- stylua: ignore end

  local lsp_clients = function()
    local clients = {}
    for _, client in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
      local name = lsp_names[client.name] or client.name
      clients[#clients + 1] = name
    end
    return " " .. table.concat(clients, " 珞 ")
  end

  lualine.setup {
    options = {
      icons_enabled = true,
      theme = "gruvbox-material",
      component_separators = "",
      section_separators = "",
      always_divide_middle = true,
      globalstatus = true,
    },
    sections = {
      lualine_a = { mode },
      lualine_b = {
        { "branch", icon = "\u{e725}" },
        { "diff" },
        { "diagnostics", colored = true },
      },
      lualine_c = {
        -- '%=', -- center
        {
          "filename",
          path = 1,
          file_status = true,
          shorting_target = 40,
          symbols = {
            modified = " \u{f040}",
            readonly = " \u{f023}",
            unnamed = "[No Name]",
          },
          cond = function()
            local f = vim.fn.expand "%:p"
            if f:len() > 6 and f:sub(0, 6) == "jdt://" then
              return false
            end
            return true
          end,
        },
        {
          filesize,
          cond = function()
            local ft = vim.api.nvim_buf_get_option(0, "filetype")
            if ft == "alpha" or ft == "NvimTree" or ft == "aerial" then
              return false
            end
            return true
          end,
        },
        -- stylua: ignore
        {
          function() return require("nvim-navic").get_location() end,
          cond = function() return require("nvim-navic").is_available() end,
        },
      },
      lualine_x = {
        lineinfo,
        {
          lsp_clients,
          cond = function()
            local ft = vim.api.nvim_buf_get_option(0, "filetype")
            if ft == "alpha" or ft == "NvimTree" or ft == "aerial" then
              return false
            end
            return next(vim.lsp.get_active_clients { bufnr = 0 }) ~= nil
          end,
        },
      },
      lualine_y = {
        { "filetype", icon_only = true, colored = true },
        { "encoding" },
      },
      lualine_z = {
        {
          "fileformat",
          icons_enabled = true,
          symbols = {
            unix = " UNIX",
            dos = " WIN",
            mac = " OSX",
          },
        },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    extensions = { "nvim-tree" },
  }
end

return M
