let b:coc_pairs_disabled = ['"']
setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
if has("nvim-0.5")
  lua require'nvim_lsp'.vimls.setup{
    root_dir = nvim_lsp.util.root_pattern('.git');
  }
endif
