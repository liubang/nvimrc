--=====================================================================
--
-- init.lua - 
--
-- Created by liubang on 2020/12/11
-- Last Modified: 2020/12/11 00:23
--
--=====================================================================

local M = {}
local o = vim.o
local g = vim.g

local bind_options = function(k, v)
  if v == true then
    vim.api.nvim_command('set ' .. k)
  elseif v == false then
    vim.api.nvim_command('set no' .. k)
  else
    vim.api.nvim_command('set ' .. k .. '=' .. v)
  end
end

M.set_globals = function()
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
end

M.set_options = function() 
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
  bind_options('relativenumber', false)
  bind_options('foldenable', true)
  bind_options('foldtext', 'folds#render()')
  bind_options('foldmethod', 'syntax')
  bind_options('foldlevelstart', 10)
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
end

M.set_mappings = function()
  g.mapleader = " "
  vim.api.nvim_set_keymap('n', ' ', '', {noremap = true})
  vim.api.nvim_set_keymap('x', ' ', '', {noremap = true})
  vim.api.nvim_set_keymap('n', ',', '', {noremap = true})
  vim.api.nvim_set_keymap('x', ',', '', {noremap = true})
  vim.api.nvim_set_keymap('n', ';', '', {noremap = true})
  vim.api.nvim_set_keymap('x', ';', '', {noremap = true})
  vim.api.nvim_set_keymap('n', 'm', '', {noremap = true})
  vim.api.nvim_set_keymap('x', 'm', '', {noremap = true})

  vim.api.nvim_set_keymap('v', "<Tab>", '>gv|', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('v', "<S-Tab>", '<gv', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', "<Tab>", '>>_', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', "<S-Tab>", '<<_', {noremap = true, silent = true})
  
  -- buffer
  vim.api.nvim_set_keymap('n', "<Leader>bp", "<cmd>bprevious<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', "<Leader>bn", "<cmd>bnext<cr>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', "<Leader>bf", "<cmd>bfirst<cr>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', "<Leader>bl", "<cmd>blast<cr>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', "<Leader>bd", "<cmd>bdelete<cr>", {noremap = true, silent = true})

  -- window
  vim.api.nvim_set_keymap('n', "<Leader>ww", "<C-W>w", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', "<Leader>wr", "<C-W>r", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', "<Leader>wd", "<C-W>d", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', "<Leader>wq", "<C-W>q", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', "<Leader>wj", "<C-W>j", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', "<Leader>wJ", "<C-W>J", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', "<Leader>wk", "<C-W>k", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', "<Leader>wK", "<C-W>K", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', "<Leader>wh", "<C-W>h", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', "<Leader>wH", "<C-W>H", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', "<Leader>wl", "<C-W>l", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', "<Leader>wL", "<C-W>L", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', "<Leader>w=", "<C-W>=", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', "<Leader>ws", "<C-W>s", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', "<Leader>w-", "<C-W>-", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', "<Leader>wv", "<C-W>v", {noremap = true, silent = true})

  vim.api.nvim_set_keymap('x', "<", "<gv", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('x', ">", ">gv", {noremap = true, silent = true})

  -- bash like
  vim.api.nvim_set_keymap('i', "<C-a>", "<Home>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('i', "<C-e>", "<End>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('i', "<C-d>", "<Delete>", {noremap = true, silent = true})

  -- command mod
  vim.api.nvim_set_keymap('c', "<C-a>", "<Home>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('c', "<C-e>", "<End>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('c', "<C-b>", "<S-Left>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('c', "<C-f>", "<S-right>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('c', "<C-h>", "<Left>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('c', "<C-l>", "<Right>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('c', "<C-n>", "pumvisible() ? '<Right>' : '<Down>'", {noremap = true, expr = true})
  vim.api.nvim_set_keymap('c', "<C-p>", "pumvisible() ? '<Left>' : '<Up>'", {noremap = true, expr = true})

  -- terminal
  vim.api.nvim_set_keymap('t', "<Esc>", "<C-\\><C-n>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('t', "<Leader>wh", "<C-\\><C-N><C-w>h", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('t', "<Leader>wj", "<C-\\><C-N><C-w>j", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('t', "<Leader>wl", "<C-\\><C-N><C-w>l", {noremap = true, silent = true})
  vim.api.nvim_set_keymap('t', "<Leader>wk", "<C-\\><C-N><C-w>k", {noremap = true, silent = true})
end

M.set_commands = function()
  vim.cmd [[command! -nargs=0 CopyRight :lua require('lb.utils.comment').copy_right('liubang')]]
end

M.run = function(root) 
  vim.cmd [[filetype off]]
  vim.cmd [[augroup vimrc]]
  vim.cmd [[  autocmd!]]
  vim.cmd [[augroup END]]
  vim.g.nvg_version = 'v2.2'
  vim.g.nvg_root = root
  M.set_mappings()
  vim.api.nvim_set_var('dein#inline_vimrcs', {
    root .. '/configs/mappings.vim',
    root .. '/configs/autocmds.vim'
  })
  vim.fn['pm#_start']()
  M.set_globals()
  M.set_options()
  M.set_commands()
end

return M
