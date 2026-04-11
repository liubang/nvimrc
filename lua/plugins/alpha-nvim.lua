-- Copyright (c) 2024 The Authors. All rights reserved.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      https://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- Authors: liubang (it.liubang@gmail.com)

return {
  "goolord/alpha-nvim", -- {{{
  event = "VimEnter",
  cmd = "Alpha",
  dependencies = { "echasnovski/mini.icons" },
  opts = function()
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
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

    dashboard.section.buttons.val = {
      dashboard.button("Space ff", " " .. " Find file", ":Telescope find_files <CR>"),
      dashboard.button("Space bb", " " .. " List buffers", ":Telescope buffers <CR>"),
      dashboard.button("Space rf", " " .. " Recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("Space ag", " " .. " Find text", ":Telescope live_grep <CR>"),
      dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
      dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("q", " " .. " Quit", ":qa<CR>"),
    }

    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end

    dashboard.section.header.opts.hl = "Keyword"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.opts.layout[1].val = 6
    return dashboard
  end,
  config = function(_, dashboard)
    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = "󰏗  Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
  -- }}}
}
