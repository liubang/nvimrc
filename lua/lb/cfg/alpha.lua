-- =====================================================================
--
-- dashboard-nvim.lua -
--
-- Created by liubang on 2021/04/19 11:15
-- Last Modified: 2022/12/01 23:47
--
-- =====================================================================

local alpha = require "alpha"

local h = {
  [[ ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓]],
  [[ ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒]],
  [[▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░]],
  [[▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ ]],
  [[▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒]],
  [[░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░]],
  [[░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░]],
  [[   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   ]],
  [[         ░    ░  ░    ░ ░        ░   ░         ░   ]],
  [[                                ░                  ]],
}

local header = {
  type = "text",
  val = h,
  opts = {
    position = "center",
    hl = "Keyword",
  },
}

-- local plugins = #vim.tbl_keys(packer_plugins)
local plugins = require("lazy.stats").stats()
local plugin_count = {
  type = "text",
  val = "└─   " .. plugins.count .. " plugins in total ─┘",
  opts = {
    position = "center",
    hl = "AlphaHeader",
  },
}

local datetime = os.date "%Y-%m-%d"
local heading = {
  type = "text",
  val = "┌─   Today is " .. datetime .. " ─┐",
  opts = {
    position = "center",
    hl = "AlphaHeader",
  },
}

local footer = {
  type = "text",
  val = "- enjoy -",
  opts = {
    position = "center",
    hl = "DashboardFooter",
  },
}

local function button(sc, txt, keybind)
  local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

  local opts = {
    position = "center",
    text = txt,
    shortcut = sc,
    cursor = 5,
    width = 50,
    align_shortcut = "right",
    hl_shortcut = "AlphaButtons",
    hl = "",
  }
  if keybind then
    opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
  end

  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = opts,
  }
end

local buttons = {
  type = "group",
  val = {
    button("SPC ff", "  > Find file", [[:lua require('telescope.builtin').find_files({previewer = false})<CR>]]),
    button("SPC bb", "  > List buffers", [[:lua require('telescope.builtin').buffers({previewer = false})<CR>]]),
    button("SPC ag", "  > Find word", [[:lua require('telescope.builtin').live_grep()<CR>]]),
    button(
      "SPC wo",
      "  > List projects",
      [[:lua require('telescope').extensions.project.project({change_dir = true})<CR>]]
    ),
    button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
    button("q", "  > Quit NVIM", ":qa<CR>"),
  },
  opts = {
    spacing = 1,
  },
}

local section = {
  header = header,
  buttons = buttons,
  plugin_count = plugin_count,
  heading = heading,
  footer = footer,
}

local opts = {
  layout = {
    { type = "padding", val = 1 },
    section.header,
    { type = "padding", val = 1 },
    section.heading,
    section.plugin_count,
    { type = "padding", val = 1 },
    section.buttons,
    { type = "padding", val = 1 },
    section.footer,
  },
  opts = {
    margin = 5,
  },
}

alpha.setup(opts)
