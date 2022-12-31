--=====================================================================
--
-- asynctasks.lua -
--
-- Created by liubang on 2022/12/30 22:20
-- Last Modified: 2022/12/30 22:20
--
--=====================================================================
return {
  "skywind3000/asynctasks.vim",
  dependencies = {
    { "skywind3000/asyncrun.vim" },
    { "skywind3000/asyncrun.extra" },
  },
  cmd = { "AsyncTask", "AsyncRun" },
  config = function() -- {{{
    vim.g.asyncrun_bell = 1
    vim.g.asyncrun_rootmarks = { ".svn", ".git", ".root", "build.xml" }
    vim.g.asynctasks_term_pos = "floaterm"
  end, -- }}}
}

-- vim: fdm=marker fdl=0
