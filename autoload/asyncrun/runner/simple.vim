function! asyncrun#runner#simple#run(opts)
    lua require("asyncrun.runner.simple").runner(vim.fn.eval("a:opts"))
endfunction
