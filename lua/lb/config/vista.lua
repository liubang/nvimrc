local g = vim.g

return function()
  g['vista#renderer#enable_icon'] = 1
  g['vista_default_executive'] = 'coc'
  g['vista_echo_cursor'] = 0
  g['vista_fzf_preview'] = {right = '50%'}
  g['vista_executive_for'] {
    vimwiki  = 'markdown',
    pandoc   = 'markdown',
    markdown = 'toc',
  }
end
