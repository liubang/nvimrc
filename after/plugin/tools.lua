--=====================================================================
--
-- tools.lua -
--
-- Created by liubang on 2022/07/21 23:49
-- Last Modified: 2022/07/21 23:49
--
--=====================================================================

-- floaterm
vim.g.floaterm_wintype = 'float'
vim.g.floaterm_position = 'bottom'
vim.g.floaterm_autoinsert = true
vim.g.floaterm_width = 0.999
vim.g.floaterm_height = 0.7
vim.g.floaterm_title = '─────  Floaterm [$1|$2] '

-- asyncrun/asynctasks
vim.g.asyncrun_open = 25
vim.g.asyncrun_bell = 1
vim.g.asyncrun_rootmarks = { '.svn', '.git', '.root', 'build.xml' }
vim.g.asynctasks_term_pos = 'floaterm'
vim.g.asynctasks_term_reuse = 1
