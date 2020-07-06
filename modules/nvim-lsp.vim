"======================================================================
"
" nvim-lsp.vim - 
"
" Created by liubang on 2020/07/05
" Last Modified: 2020/07/05 21:19
"
"======================================================================

if !has("nvim-0.5") 
  finish 
endif

let g:deoplete#enable_at_startup = 1

function! SetMyLspConfig() abort
  setlocal omnifunc=v:lua.vim.lsp.omnifunc
  nnoremap <buffer><silent><c-]>       <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <buffer><silent><c-k>       <cmd>lua vim.lsp.buf.signature_help()<CR>
  nnoremap <buffer><silent>K           <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap <buffer><silent><Leader>gd  <cmd>lua vim.lsp.buf.declaration()<CR>
  nnoremap <buffer><silent><Leader>gdo <cmd>lua vim.lsp.buf.document_symbol()<CR>
  nnoremap <buffer><silent><Leader>gi  <cmd>lua vim.lsp.buf.implementation()<CR>
  nnoremap <buffer><silent><Leader>td  <cmd>lua vim.lsp.buf.type_definition()<CR>
  nnoremap <buffer><silent><Leader>rf  <cmd>lua vim.lsp.buf.references({ includeDeclaration = true })<CR>
  nnoremap <buffer><silent><Leader>fm  <cmd>lua vim.lsp.buf.formatting()<CR>
  nnoremap <buffer><silent><Leader>rn  <cmd>lua vim.lsp.buf.rename()<CR>
endfunction

autocmd Filetype c,cpp,php,java,go,rust,python,javascript,json,typescript call SetMyLspConfig() 
      \ | lua require'completion'.on_attach()

let g:completion_enable_auto_popup = 1
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c

:lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,                    -- false will disable the whole extension
    disable = {},        -- list of language that will be disabled
  },
  incremental_selection = {
    enable = true,
    disable = {},
    keymaps = {                       -- mappings for incremental selection (visual mappings)
      init_selection = 'gnn',         -- maps in normal mode to init the node/scope selection
      node_incremental = "grn",       -- increment to the upper named parent
      scope_incremental = "grc",      -- increment to the upper scope (as defined in locals.scm)
      node_decremental = "grm",       -- decrement to the previous node
    }
  },
  refactor = {
    highlight_defintions = {
      enable = true
    },
    smart_rename = {
      enable = true,
      smart_rename = "grr"              -- mapping to rename reference under cursor
    },
    navigation = {
      enable = true,
      goto_definition = "gnd",          -- mapping to go to definition of symbol under cursor
      list_definitions = "gnD"          -- mapping to list all definitions in current file
    }
  },
  ensure_installed = 'all' -- one of 'all', 'language', or a list of languages
}
EOF
