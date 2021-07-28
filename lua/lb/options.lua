-- =====================================================================
--
-- options.lua - 
--
-- Created by liubang on 2020/12/12 13:01
-- Last Modified: 2020/12/12 13:01
--
-- =====================================================================
local opt = vim.opt

opt.clipboard = 'unnamedplus'
opt.shortmess = 'aoOTIcF'
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
opt.pumheight = 15
opt.winminheight = 0
opt.backspace = 'eol,start,indent'
opt.whichwrap = 'b,s,<,>,h,l'
opt.fileformats = 'unix,mac,dos'
opt.autoread = true
opt.errorbells = false
opt.visualbell = false
opt.listchars = {
  tab = '»·',
  nbsp = '+',
  trail = '·',
  extends = '→',
  precedes = '←',
}
opt.switchbuf = 'useopen,uselast'
opt.autochdir = false
opt.viewoptions = 'folds,cursor,curdir,slash,unix'
opt.sessionoptions = 'curdir,help,tabpages,winsize'
opt.splitright = true
opt.splitbelow = true
opt.clipboard = 'unnamedplus'
opt.mouse = 'v'
opt.laststatus = 2
opt.showtabline = 2
opt.wildignorecase = true
-- Ignore compiled files
opt.wildignore = '__pycache__'
opt.wildignore = opt.wildignore + {'*.o', '*~', '*.pyc', '*pycache*'}
opt.wildoptions = 'pum'
opt.wildmode = {'longest', 'list', 'full'}
opt.wildmode = opt.wildmode - 'list'
opt.wildmode = opt.wildmode + {'longest', 'full'}
opt.pumblend = 17
opt.shada = {'!', '\'1000', '<50', 's10', 'h'}
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
-- LuaFormatter off
-- TODO: w, {v, b, l}
opt.formatoptions = opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore
-- LuaFormatter on
opt.textwidth = 100
opt.colorcolumn = {'100'}
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.autoindent = true
opt.smartindent = true
opt.cindent = true
opt.wrap = true
opt.number = true
opt.list = false
opt.relativenumber = false
opt.foldenable = true
opt.foldtext = 'v:lua.folds_render()'
opt.foldmethod = 'syntax'
opt.foldlevelstart = 10
opt.cursorline = true
opt.cursorcolumn = false
