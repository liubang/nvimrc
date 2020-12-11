--=====================================================================
--
-- comment.lua - 
--
-- Created by liubang on 2020/12/11
-- Last Modified: 2020/12/11 17:32
--
--=====================================================================
local comment = {}

local prefix_mappings = {
  [c]                 = "//",
  [cpp]               = '//',
  [rust]              = '//',
  [go]                = '//',
  [php]               = '//',
  [java]              = '//',
  [lua]               = '--',
  [sql]               = '--',
  [python]            = '#',
  [sh]                = '#',
  [zsh]               = '#',
  [bash]              = '#',
  [make]              = '#',
  [ruby]              = '#',
}

local header_mappings = {
  [python]              = {"#! /usr/bin/env python", "# -*- coding: utf-8 -*-"},
  [php]                 = {"<?php"},
  [sh]                  = {"#! /bin/sh"},
  [bash]                = {"#! /usr/bin/env bash"},
  [zsh]                 = {"#! /usr/bin/env zsh"},
}

comment.comment_prefix = function()
  local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
  if prefix_mappings[filetype] ~= nil then
    return prefix_mappings[filetype]
  end
  return '#'
end

comment.comment_line = function(c, r)
  local prefix = comment.comment_prefix()
  while (string.len(prefix) < r) do
    prefix = prefix .. c
  end
  return prefix
end

comment.copy_right = function(author)
  local c = comment.comment_prefix()
  local complete = comment.comment_line('=', 71)
  local filename = vim.fn.expand('%:t')
  local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
  local t = os.date("%Y/%m/%d %H:%M")
  local text = {}
  if header_mappings[filetype] ~= nil then
    for k, v in pairs(header_mappings[filetype]) do
      table.insert(text, v)
    end
  end
  table.insert(text, complete) 
  table.insert(text, c)
  table.insert(text, c .. ' ' .. filename .. ' - ')
  table.insert(text, c)
  table.insert(text, c .. ' Created by ' .. author ..  ' on ' .. t)
  table.insert(text, c .. ' Last Modified: ' .. t )
  table.insert(text, c)
  table.insert(text, complete) 
  api.nvim_buf_set_lines(tree.bufnr, 0, -1, false, text)
end

return comment
