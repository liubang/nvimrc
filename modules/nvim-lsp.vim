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
