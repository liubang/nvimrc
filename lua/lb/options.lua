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

vim.opt.cursorline = true
vim.opt.cursorcolumn = false
vim.opt.shortmess:append("filmnrxoOtTAIc")
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.termguicolors = true
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.modeline = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hidden = true
vim.opt.cmdheight = 1
vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.history = 2000
vim.opt.hlsearch = true
vim.opt.writebackup = false
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.shiftround = true
vim.opt.timeout = true
vim.opt.ttimeout = true
vim.opt.updatetime = 120
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 10
vim.opt.redrawtime = 1500
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.report = 0
vim.opt.linespace = 0
vim.opt.pumheight = 20
vim.opt.winminheight = 0
vim.opt.backspace = "eol,start,indent"
vim.opt.whichwrap:append("h,l")
vim.opt.fileformats = "unix,mac,dos"
vim.opt.autoread = true
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.list = false
vim.opt.listchars = { -- {{{
  tab = "»·",
  nbsp = "+",
  trail = "·",
  extends = "→",
  precedes = "←",
} -- }}}
vim.opt.title = true
vim.opt.switchbuf = "useopen,uselast"
vim.opt.autochdir = false
vim.opt.viewoptions:append("localoptions")
vim.opt.sessionoptions = "curdir,help,tabpages,winsize"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.mouse = nil
vim.opt.laststatus = 2
vim.opt.scrolloff = 3 -- keep 3 lines visible while scrolling
vim.opt.sidescrolloff = 15
vim.opt.sidescroll = 1
-- Ignore compiled files
-- stuff to ignore when tab completing
vim.opt.wildignore = { -- {{{
  "*~",
  "*.o",
  "*.obj",
  "*.so",
  "*vim/backups*",
  "*.git/**",
  "**/.git/**",
  "*sass-cache*",
  "*DS_Store*",
  "vendor/rails/**",
  "vendor/cache/**",
  "*.gem",
  "*.pyc",
  "log/**",
  "*.png",
  "*.jpg",
  "*.gif",
  "*.zip",
  "*.bg2",
  "*.gz",
  "*.db",
  "**/node_modules/**",
  "**/bin/**",
  "**/thesaurus/**",
} --}}}
vim.opt.wildoptions = "pum"
vim.opt.wildmode = { "longest:full", "list", "full" }
vim.opt.wildignorecase = true
vim.opt.wildcharm = vim.fn.char2nr("	") -- tab
vim.opt.shada = "!,'10000,<1000,s100,h,f1,:100000,@10000,/1000"
vim.opt.inccommand = "nosplit"
vim.opt.diffopt:append("indent-heuristic")
vim.opt.diffopt:append("algorithm:patience")
vim.opt.diffopt:append("context:3")
vim.opt.diffopt:append("foldcolumn:1")
vim.opt.fillchars = { -- {{{
  vert = "│",
  fold = "·",
  diff = "",
  msgsep = "‾",
  eob = " ",
  foldopen = "▾",
  foldsep = "│",
  foldclose = "▸",
} -- }}}
vim.opt.synmaxcol = 2500
vim.opt.formatoptions = "jcroqlnt" -- tcqj
-- }}}
vim.opt.grepprg = "rg --vimgrep"
vim.opt.textwidth = 100
vim.opt.colorcolumn = { "100" }
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
-- vim.opt.cindent = true
vim.opt.wrap = true
vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.breakindent = true
vim.opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
vim.opt.linebreak = true

-- Folding and indent {{{
vim.opt.foldnestmax = 3
vim.opt.foldlevelstart = 100
vim.opt.foldmethod = "expr"
--}}}

-- python {{{
local python_host_prog = os.getenv("PYTHON_HOST_PROG")
local python3_host_prog = os.getenv("PYTHON3_HOST_PROG")

if python_host_prog ~= nil then
  vim.g.python_host_prog = python_host_prog
end
if python3_host_prog ~= nil then
  vim.g.python3_host_prog = python3_host_prog
end
-- }}}

vim.opt.clipboard = "unnamedplus"

-- vim: fdm=marker fdl=0
