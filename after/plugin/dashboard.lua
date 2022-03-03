-- =====================================================================
--
-- dashboard-nvim.lua -
--
-- Created by liubang on 2021/04/19 11:15
-- Last Modified: 2021/04/19 11:15
--
-- =====================================================================

local if_nil = vim.F.if_nil
local alpha = require 'alpha'

local default_header = {
  type = 'text',
  val = {
    [[                                                          ]],
    [[ ██▓     ██▓ █    ██  ▄▄▄▄    ▄▄▄       ███▄    █   ▄████ ]],
    [[▓██▒    ▓██▒ ██  ▓██▒▓█████▄ ▒████▄     ██ ▀█   █  ██▒ ▀█▒]],
    [[▒██░    ▒██▒▓██  ▒██░▒██▒ ▄██▒██  ▀█▄  ▓██  ▀█ ██▒▒██░▄▄▄░]],
    [[▒██░    ░██░▓▓█  ░██░▒██░█▀  ░██▄▄▄▄██ ▓██▒  ▐▌██▒░▓█  ██▓]],
    [[░██████▒░██░▒▒█████▓ ░▓█  ▀█▓ ▓█   ▓██▒▒██░   ▓██░░▒▓███▀▒]],
    [[░ ▒░▓  ░░▓  ░▒▓▒ ▒ ▒ ░▒▓███▀▒ ▒▒   ▓▒█░░ ▒░   ▒ ▒  ░▒   ▒ ]],
    [[░ ░ ▒  ░ ▒ ░░░▒░ ░ ░ ▒░▒   ░   ▒   ▒▒ ░░ ░░   ░ ▒░  ░   ░ ]],
    [[  ░ ░    ▒ ░ ░░░ ░ ░  ░    ░   ░   ▒      ░   ░ ░ ░ ░   ░ ]],
    [[    ░  ░ ░     ░      ░            ░  ░         ░       ░ ]],
    [[                           ░                              ]],
    [[                                                          ]],
    [[                                                          ]],
  },
  opts = {
    position = 'center',
    hl = 'Keyword',
  },
}

local function footer_val()
  local plugins = #vim.tbl_keys(packer_plugins)
  local v = vim.version()
  return string.format('  %s    v%s.%s.%s', plugins, v.major, v.minor, v.patch)
end

local footer = {
  type = 'text',
  val = footer_val(),
  opts = {
    position = 'center',
    -- hl = 'Number',
  },
}

local leader = 'SPC'

local function button(sc, txt, keybind, keybind_opts)
  local sc_ = sc:gsub('%s', ''):gsub(leader, '<leader>')

  local opts = {
    position = 'center',
    shortcut = sc,
    cursor = 5,
    width = 50,
    align_shortcut = 'right',
    -- hl_shortcut = 'Keyword',
  }
  if keybind then
    keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
    opts.keymap = { 'n', sc_, keybind, keybind_opts }
  end

  local function on_press()
    local key = vim.api.nvim_replace_termcodes(sc_ .. '<Ignore>', true, false, true)
    vim.api.nvim_feedkeys(key, 'normal', false)
  end

  return {
    type = 'button',
    val = txt,
    on_press = on_press,
    opts = opts,
  }
end

local buttons = {
  type = 'group',
  val = {
    button(
      'SPC ff',
      '  > Find file',
      [[:lua require('telescope.builtin').find_files({previewer = false})<CR>]]
    ),
    button(
      'SPC bb',
      '  > List buffers',
      [[:lua require('telescope.builtin').buffers({previewer = false})<CR>]]
    ),
    button('SPC ag', ' > Find word', [[:lua require('telescope.builtin').live_grep()<CR>]]),
    button(
      'SPC wo',
      '  > List projects',
      [[:lua require('telescope').extensions.project.project({change_dir = true})<CR>]]
    ),
    button('e', '  > New file', ':ene <BAR> startinsert <CR>'),
    button('q', '  > Quit NVIM', ':qa<CR>'),
  },
  opts = {
    spacing = 1,
  },
}

local section = {
  header = default_header,
  buttons = buttons,
  footer = footer,
}

local config = {
  layout = {
    { type = 'padding', val = 2 },
    section.header,
    { type = 'padding', val = 2 },
    section.buttons,
    section.footer,
  },
  opts = {
    margin = 5,
  },
}

alpha.setup(config)

-- set header
-- dashboard.section.header.opts.hl = 'Keyword'
