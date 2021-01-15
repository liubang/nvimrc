-- =====================================================================
--
-- coc.lua - 
--
-- Created by liubang on 2020/12/11
-- Last Modified: 2020/12/11 00:23
--
-- =====================================================================
local function get_lua_runtime()
  local result = {};
  for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
    local lua_path = path .. '/lua/';
    if vim.fn.isdirectory(lua_path) then
      result[lua_path] = true
    end
  end
  -- This loads the `lua` files from nvim into the runtime.
  result[vim.fn.expand('$VIMRUNTIME/lua')] = true
  return result;
end

local set_config = function()
  vim.g.coc_global_extensions = {
    'coc-lists',
    'coc-emoji',
    'coc-diagnostic',
    'coc-prettier',
    'coc-snippets',
    'coc-pairs',
    'coc-git',
    'coc-json',
    'coc-yaml',
    'coc-vimlsp',
    'coc-xml',
    'coc-calc',
    'coc-cmake',
    'coc-ci',
    'coc-tsserver',
    'coc-vetur',
    'coc-eslint',
    'coc-css',
    'coc-emmet',
    'coc-stylelint',
    'coc-java',
    'coc-jedi',
    'coc-rls',
    'coc-docker',
    'coc-sh',
  }
  vim.g.coc_snippet_next = '<TAB>'
  vim.g.coc_snippet_prev = '<S-TAB>'

  -- lua lsp config
  local lua_ls_path = vim.g.cache_path .. '/lua-language-server'
  local lua_ls_bin = ''
  if jit.os == 'OSX' then
    lua_ls_bin = lua_ls_path .. '/bin/macOS/lua-language-server'
  elseif jit.os == 'Linux' then
    lua_ls_bin = lua_ls_path .. '/bin/Linux/lua-language-server'
  end
  vim.fn['coc#config']('languageserver.lua', {
    cwd = lua_ls_path,
    command = lua_ls_bin,
    args = {'-E', '-e', 'LANG="zh-cn"', lua_ls_path .. '/main.lua'},
    filetypes = {'lua'},
    rootPatterns = {'.git/', ''},
    settings = {
      Lua = {
        workspace = {library = get_lua_runtime(), maxPreload = 2000, preloadFileSize = 1000},
        runtime = {version = 'LuaJIT'},
        completion = {
          -- You should use real snippets
          keywordSnippet = 'Disable',
        },
        diagnostics = {
          enable = true,
          disable = {'trailing-space'},
          globals = {
            -- Neovim
            'vim',
            -- Busted
            'describe',
            'it',
            'before_each',
            'after_each',
            'teardown',
            'pending',
          },
        },
      },
    },
  })

  -- cpp lsp config
  local ccls_init = {cache = {directory = '/tmp/ccls'}}
  if jit.os == 'OSX' then
    ccls_init.clang = {
      resourceDir = os.getenv('CLANG_RESOURCEDIR') or '',
      extraArgs = {'-isystem', os.getenv('CLANG_ISYSTEM') or '', '-I', os.getenv('CLANG_INCLUDE') or ''},
    }
  elseif jit.os == 'Linux' then
    ccls_init.clang = {extraArgs = {'--gcc-toolchain=/usr'}}
  end
  vim.fn['coc#config']('languageserver.ccls', {
    command = 'ccls',
    filetypes = {'c', 'cpp', 'objc', 'objcpp'},
    rootPatterns = {'.ccls', '.git/', 'compile_commands.json'},
    initializationOptions = ccls_init,
  })
  -- snippets config
  vim.fn['coc#config']('snippets.textmateSnippetsRoots', {vim.g.snip_path})
  -- session config
  vim.fn['coc#config']('session.directory', vim.g.cache_path .. '/sessions')
end

local set_highlight = function()
  -- coc-git
  vim.cmd [[highlight DiffAdd ctermfg=22 guifg=#006000 ctermbg=NONE guibg=NONE]]
  vim.cmd [[highlight DiffChange ctermfg=58 guifg=#5F6000 ctermbg=NONE guibg=NONE]]
  vim.cmd [[highlight DiffDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE]]
  vim.cmd [[highlight default CocHighlightText  guibg=#725972 ctermbg=96]]
  -- virtual text
  vim.cmd [[highlight! CocCodeLens guifg=#606060 ctermfg=60]]
  -- error/warning/info/hit
  vim.cmd [[highlight! CocErrorSign ctermfg=Red guifg=#ea6962]]
  vim.cmd [[highlight! CocWarningSign ctermfg=Yellow guifg=#e3a84e]]
  vim.cmd [[highlight! CocInfoSign ctermfg=Blue guifg=#7dae9b]]
  vim.cmd [[highlight! CocHintSign ctermfg=Blue guifg=#7dae9b]]
  -- diff 
  vim.cmd [[highlight GitAddHi guifg=#b8bb26 ctermfg=40]]
  vim.cmd [[highlight GitModifyHi guifg=#83a598 ctermfg=33]]
  vim.cmd [[highlight GitDeleteHi guifg=#f3423a ctermfg=196]]
  vim.cmd [[highlight CocCursorRange guibg=#b16286 guifg=#ebdbb2]]
  -- highlight text color
  vim.cmd [[highlight! CocHighlightText guibg=#054c20 ctermbg=023]]
end

local set_command = function()
  vim.schedule(function()
    vim.cmd [[command! -nargs=0 Format :call CocAction('format')]]
    vim.cmd [[command! -nargs=0 OR     :call CocAction('runCommand', 'editor.action.organizeImport')]]
    vim.cmd [[command! -nargs=? Fold   :call CocAction('fold', <f-args>)]]
  end)
end

local set_autocmd = function()
  vim.cmd [[augroup coc_au]]
  vim.cmd [[  autocmd!]]
  vim.cmd [[  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')]]
  vim.cmd [[  autocmd User CocQuickfixChange :CocList --normal quickfix]]
  vim.cmd [[  autocmd CursorHold * silent call CocActionAsync('highlight')]]
  vim.cmd [[  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif]]
  vim.cmd [[augroup END]]
end

local on_attach = function()
  set_config()
  set_highlight()
  set_autocmd()
  set_command()
end

return {on_attach = on_attach}
