local M = {}

local lspprotocol = require('vim.lsp.protocol')

lspprotocol.CompletionItemKind = {
  ' Text', -- = 1
  'ƒ Method', -- = 2;
  ' Function', -- = 3;
  ' Constructor', -- = 4;
  '綠Field', -- = 5;
  ' Variable', -- = 6;
  ' Class', -- = 7;
  '禍Interface', -- = 8;
  ' Module', -- = 9;
  ' Property', -- = 10;
  ' Unit', -- = 11;
  ' Value', -- = 12;
  ' Enum', -- = 13;
  ' Keyword', -- = 14;
  ' Snippet', -- = 15;
  ' Color', -- = 16;
  ' File', -- = 17;
  '  Reference', -- = 18;
  ' Folder', -- = 19;
  ' EnumMember', -- = 20;
  ' Constant', -- = 21;
  ' Struct', -- = 22;
  '鬒Event', -- = 23;
  '洛Operator', -- = 24;
  '  TypeParameter', -- = 25;
}

-- define commands
vim.schedule(function()
  vim.cmd [[command! -nargs=0 Format :lua vim.lsp.buf.formatting()]]
end)

local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
custom_capabilities.textDocument.completion.completionItem.snippetSupport = true
custom_capabilities.textDocument.completion.completionItem.resolveSupport =
  {properties = {'documentation', 'detail', 'additionalTextEdits'}}

-- custom attach function
local opts = {noremap = true, silent = true}
local function buf_set_keymap(...)
  vim.api.nvim_buf_set_keymap(bufnr, ...)
end
-- LuaFormatter off
local custom_attach = function(client, bufnr)
  buf_set_keymap('n', '<Leader>gD', ':lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<Leader>gd', ':lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>gi', ':lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<Leader>gr', ':lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<Leader>hh', ':lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Leader>rn', ':lua MyLspRename()<CR>', opts)
  buf_set_keymap('n', '<Leader>ee', ':lua require("lspsaga.diagnostic").show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<Leader>ca', ':lua require("lspsaga.codeaction").code_action()<CR>', opts)
  buf_set_keymap('v', '<Leader>ca', ':<C-U>lua require("lspsaga.codeaction").range_code_action()<CR>', opts)
  buf_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', opts)
  -- format
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap('n', '<Leader>fm', ':lua vim.lsp.buf.formatting()<CR>', opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap('v', '<Leader>fm', ':lua vim.lsp.buf.formatting()<CR>', opts)
  end
end
-- LuaFormatter on

M.default = function(configs)
  local custom_config = {
    on_attach = custom_attach,
    capabilities = custom_capabilities,
  }
  if configs ~= nil then
    for key, value in pairs(configs) do
      custom_config[key] = value
    end
  end
  return custom_config
end

return M
