--=====================================================================
--
-- asynctasks.lua -
--
-- Created by liubang on 2023/11/26 16:06
-- Last Modified: 2023/11/26 16:06
--
--=====================================================================

return {
  "skywind3000/asynctasks.vim", -- {{{
  dependencies = {
    { "skywind3000/asyncrun.vim" },
  },
  cmd = { "AsyncTask", "AsyncRun" },
  config = function() -- {{{
    vim.g.asyncrun_bell = 1
    vim.g.asyncrun_rootmarks = { ".svn", ".git", ".root", "build.xml" }
    vim.g.asynctasks_term_pos = "floaterm"
  end, -- }}}
  keys = {
    { "<C-b>", "<CMD>AsyncTask file-build<CR>", mode = { "n" }, desc = "Build current file" },
    { "<C-r>", "<CMD>AsyncTask file-run<CR>", mode = { "n" }, desc = "Run current file" },
    { "<C-x>", "<CMD>AsyncTask file-build-run<CR>", mode = { "n" }, desc = "Build and run current file" },
  },
  -- }}}
}
