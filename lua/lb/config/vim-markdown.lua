-- =====================================================================
--
-- vim-markdown.lua - 
--
-- Created by liubang on 2020/12/12 21:10
-- Last Modified: 2020/12/12 21:10
--
-- =====================================================================
local g = vim.g

g.vim_markdown_folding_level = 1
g.vim_markdown_folding_style_pythonic = 1
g.vim_markdown_frontmatter = 1
g.vim_markdown_auto_insert_bullets = 1
g.vim_markdown_new_list_item_indent = 0
g.vim_markdown_conceal_code_blocks = 0
g.vim_markdown_conceal = 0
g.vim_markdown_strikethrough = 1
g.vim_markdown_edit_url_in = 'vsplit'
g.vim_markdown_fenced_languages = {
  'c++=cpp',
  'viml=vim',
  'bash=sh',
  'ini=dosini',
  'js=javascript',
  'json=javascript',
  'jsx=javascriptreact',
  'tsx=typescriptreact',
  'docker=Dockerfile',
  'makefile=make',
  'py=python'
}
