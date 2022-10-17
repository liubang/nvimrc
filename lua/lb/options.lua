-- =====================================================================
--
-- options.lua -
--
-- Created by liubang on 2020/12/12 13:01
-- Last Modified: 2020/12/12 13:01
--
-- =====================================================================
local opt = vim.opt

-- opt.shortmess = 'aoOTIcF'
opt.cursorline = true
opt.cursorcolumn = false
opt.shortmess:append 'filmnrxoOtTAIc'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
opt.termguicolors = true
opt.completeopt = 'menuone,noselect'
opt.modeline = true
opt.ignorecase = true
opt.smartcase = true
opt.hidden = true
opt.cmdheight = 1
opt.showcmd = false
opt.showmode = false
opt.history = 2000
opt.hlsearch = true
opt.writebackup = false
opt.backup = false
opt.swapfile = false
opt.shiftround = true
opt.timeout = true
opt.ttimeout = true
opt.updatetime = 120
opt.timeoutlen = 500
opt.ttimeoutlen = 10
opt.redrawtime = 1500
opt.showmatch = true
opt.matchtime = 2
opt.lazyredraw = true
opt.report = 0
opt.linespace = 0
opt.pumheight = 20
opt.winminheight = 0
opt.backspace = 'eol,start,indent'
opt.whichwrap = 'b,s,<,>,h,l'
opt.fileformats = 'unix,mac,dos'
opt.autoread = true
opt.errorbells = false
opt.visualbell = false
opt.list = false
opt.listchars = {
  tab = '»·',
  nbsp = '+',
  trail = '·',
  extends = '→',
  precedes = '←',
}
opt.title = true
opt.switchbuf = 'useopen,uselast'
opt.autochdir = false
opt.viewoptions:append 'localoptions'
opt.sessionoptions = 'curdir,help,tabpages,winsize'
opt.splitright = true
opt.splitbelow = true
opt.clipboard = 'unnamedplus'
opt.mouse = 'v'
opt.laststatus = 2
opt.showtabline = 2
opt.scrolloff = 3 -- keep 3 lines visible while scrolling
opt.sidescrolloff = 15
opt.sidescroll = 1
-- Ignore compiled files
-- stuff to ignore when tab completing
opt.wildignore = {
  '*~',
  '*.o',
  '*.obj',
  '*.so',
  '*vim/backups*',
  '*.git/**',
  '**/.git/**',
  '*sass-cache*',
  '*DS_Store*',
  'vendor/rails/**',
  'vendor/cache/**',
  '*.gem',
  '*.pyc',
  'log/**',
  '*.png',
  '*.jpg',
  '*.gif',
  '*.zip',
  '*.bg2',
  '*.gz',
  '*.db',
  '**/node_modules/**',
  '**/bin/**',
  '**/thesaurus/**',
} --}}}
opt.wildoptions = 'pum'
opt.wildmode = { 'longest:full', 'list', 'full' }
opt.wildignorecase = true
opt.wildcharm = vim.fn.char2nr '	' -- tab
opt.shada = '!,\'10000,<1000,s100,h,f1,:100000,@10000,/1000'
opt.inccommand = 'nosplit'
opt.fillchars = {
  vert = '│',
  fold = '·',
  diff = '',
  msgsep = '‾',
  eob = ' ',
  foldopen = '▾',
  foldsep = '│',
  foldclose = '▸',
}
opt.synmaxcol = 2500
opt.formatoptions = opt.formatoptions
  - 'a' -- Auto formatting is BAD.
  - 't' -- Don't auto format my code. I got linters for that.
  + 'c' -- In general, I like it when comments respect textwidth
  + 'q' -- Allow formatting comments w/ gq
  - 'o' -- O and o, don't continue comments
  + 'r' -- But do continue when pressing enter.
  + 'n' -- Indent past the formatlistpat, not underneath it.
  + 'j' -- Auto-remove comments if possible.
  - '2' -- I'm not in gradeschool anymore
opt.textwidth = 100
opt.colorcolumn = { '100' }
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.autoindent = true
opt.smartindent = true
opt.cindent = true
opt.wrap = true
opt.number = true
opt.relativenumber = false

opt.breakindent = true
opt.showbreak = string.rep(' ', 3) -- Make it so that long lines wrap smartly
opt.linebreak = true

-- Folding {{{
vim.opt.foldnestmax = 3
vim.opt.foldlevelstart = 1
--}}}

-- python {{{
local python_host_prog = os.getenv 'PYTHON_HOST_PROG'
local python3_host_prog = os.getenv 'PYTHON3_HOST_PROG'

if python_host_prog ~= nil then
  vim.g.python_host_prog = python_host_prog
end
if python3_host_prog ~= nil then
  vim.g.python3_host_prog = python3_host_prog
end
-- }}}

-- disable distribution plugins {{{
-- stylua: ignore start
vim.g.loaded_matchparen        = 1
vim.g.loaded_gzip              = 1
vim.g.loaded_tar               = 1
vim.g.loaded_tarPlugin         = 1
vim.g.loaded_zip               = 1
vim.g.loaded_zipPlugin         = 1
vim.g.loaded_getscript         = 1
vim.g.loaded_getscriptPlugin   = 1
vim.g.loaded_vimball           = 1
vim.g.loaded_vimballPlugin     = 1
vim.g.loaded_matchit           = 1
vim.g.loaded_2html_plugin      = 1
vim.g.loaded_logiPat           = 1
vim.g.loaded_rrhelper          = 1
vim.g.loaded_netrw             = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_netrwSettings     = 1
vim.g.loaded_netrwFileHandlers = 1
-- stylua: ignore end
-- }}}

-- neowide {{{
vim.cmd [[set guifont=Operator\ Mono\ Lig:h16,Hack\ Nerd\ Font:h16]]
vim.g.neovide_refresh_rate = 60
vim.g.neovide_cursor_vfx_mode = 'railgun'
vim.g.neovide_no_idle = true
vim.g.neovide_cursor_animation_length = 0.03
vim.g.neovide_cursor_trail_length = 0.05
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_vfx_opacity = 200.0
vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
vim.g.neovide_cursor_vfx_particle_speed = 20.0
vim.g.neovide_cursor_vfx_particle_density = 5.0
--}}}

-- global functions {{{
_G.P = function(v)
  print(vim.inspect(v))
  return v
end
-- }}}

-- vim: fdm=marker fdl=0
