setlocal expandtab cindent tabstop=2 shiftwidth=2 softtabstop=2
if has('nvim-0.5')
  lua require'nvim_lsp'.ccls.setup{}
endif
