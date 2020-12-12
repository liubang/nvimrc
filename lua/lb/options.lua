--=====================================================================
--
-- options.lua - 
--
-- Created by liubang on 2020/12/12 13:01
-- Last Modified: 2020/12/12 13:01
--
--=====================================================================

local g = vim.g
local o = vim.o
local python_host_prog = os.getenv("PYTHON_HOST_PROG")
local python3_host_prog = os.getenv("PYTHON3_HOST_PROG")

local function bind_options(k, v)
  if v == true then
    vim.api.nvim_command('set ' .. k)
  elseif v == false then
    vim.api.nvim_command('set no' .. k)
  else
    vim.api.nvim_command('set ' .. k .. '=' .. v)
  end
end

if python_host_prog ~= nil then
  g.python_host_prog = python_host_prog
end

if python3_host_prog ~= nil then
  g.python3_host_prog = python3_host_prog
end

g.mapleader = " "
g.loaded_gzip              = 1
g.loaded_tar               = 1
g.loaded_tarPlugin         = 1
g.loaded_zip               = 1
g.loaded_zipPlugin         = 1
g.loaded_getscript         = 1
g.loaded_getscriptPlugin   = 1
g.loaded_vimball           = 1
g.loaded_vimballPlugin     = 1
g.loaded_matchit           = 1
g.loaded_2html_plugin      = 1
g.loaded_logiPat           = 1
g.loaded_rrhelper          = 1
g.loaded_netrw             = 1
g.loaded_netrwPlugin       = 1
g.loaded_netrwSettings     = 1
g.loaded_netrwFileHandlers = 1
g.clipboard = {
  name = "macOS-clipboard",
  copy = {
    ["+"] = "pbcopy",
    ["*"] = "pbcopy",
  },
  paste = {
    ["+"] = "pbpaste",
    ["*"] = "pbpaste",
  },
  cache_enabled = 0
}

o.shortmess = "aoOTIcF"
o.encoding = 'utf-8'
o.fileencoding = 'utf-8' 
o.termguicolors = true
o.completeopt = "menu,noinsert,noselect,longest"
o.modeline = true
o.smartcase = true
o.hidden = true
o.cmdheight = 1
o.showcmd = false
o.showmode = false
o.history = 2000
o.hlsearch = true
o.writebackup = false
o.backup = false
o.swapfile = false
o.shiftround = true
o.timeout = true
o.ttimeout = true
o.updatetime = 120
o.timeoutlen = 500
o.ttimeoutlen = 10
o.redrawtime = 1500
o.showmatch = true
o.matchtime = 2
o.lazyredraw = true
o.report = 0
o.linespace = 0
o.pumheight = 15
o.winminheight = 0
o.backspace = 'eol,start,indent'
o.whichwrap = 'b,s,<,>,h,l'
o.cursorline = true
o.fileformats = 'unix,mac,dos'
o.autoread = true
o.cursorcolumn = false
o.errorbells = false
o.visualbell = false
o.t_vb = ''
o.listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←'
o.switchbuf = 'useopen,uselast'
o.autochdir = false
o.viewoptions = 'folds,cursor,curdir,slash,unix'
o.sessionoptions = 'curdir,help,tabpages,winsize'
o.splitright = true
o.splitbelow = true
o.clipboard = 'unnamedplus'
o.mouse = 'vr'
o.laststatus = 2
o.showtabline = 2
o.grepformat = "%f:%l:%c:%m";
o.grepprg = 'rg --hidden --vimgrep --smart-case --';
o.wildignorecase = true
o.wildignore = '*.aux,*.out,*.toc' ..
                '*.o,*.obj,*.dll,*.jar,*.pyc,*.rbc,*.class' .. 
                '*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp' ..
                '*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm' ..
                '*.eot,*.otf,*.ttf,*.woff' ..
                '*.doc,*.pdf' ..
                '*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz' ..
                '*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*.gem' .. 
                '*.*~,*~' ..
                '*.swp,.lock,.DS_Store,._*,tags.lock'
o.shada = "!,'300,<50,@100,s10,h"
o.inccommand = "nosplit"
o.wildoptions = 'pum'
o.pumblend = 3

bind_options('synmaxcol', 2500)
bind_options('formatoptions', '1n2jvcroql')
bind_options('textwidth', 120)
bind_options('expandtab', true)
bind_options('tabstop', 2)
bind_options('shiftwidth', 2)
bind_options('softtabstop', 2)
bind_options('autoindent', true)
bind_options('smartindent', true)
bind_options('cindent', true)
bind_options('wrap', true)
bind_options('number', true)
bind_options('list', false)
bind_options('relativenumber', false)
bind_options('foldenable', true)
bind_options('foldtext', 'folds#render()')
bind_options('foldmethod', 'syntax')
bind_options('foldlevelstart', 10)
