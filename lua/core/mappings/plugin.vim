"" plugin.vim
" Keymappings related to plugins.
""

" nvim-tree
nnoremap <leader>ntt <cmd>NvimTreeToggle<cr>
nnoremap <leader>ntf <cmd>NvimTreeFindFile<cr>

" telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" bufferline
nnoremap <leader>[b <cmd>BufferLineCycleNext<cr>
nnoremap <leader>]b <cmd>BufferLineCyclePrev<cr>
nnoremap <leader>bD <cmd>:BufferLinePickClose<CR>
nnoremap <leader>bP <cmd>:BufferLinePick<CR>

" vim-oscyank
nmap <leader>c <Plug>OSCYankOperator
nmap <leader>cc <leader>c_
vmap <leader>c <Plug>OSCYankVisual

" vim-flog
nnoremap <leader>gb <cmd>Flog<cr>

" jdtls
nnoremap <A-o> <Cmd>lua require'jdtls'.organize_imports()<CR>
nnoremap crv <Cmd>lua require('jdtls').extract_variable()<CR>
vnoremap crv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
nnoremap crc <Cmd>lua require('jdtls').extract_constant()<CR>
vnoremap crc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
vnoremap crm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>

nnoremap <leader>df <Cmd>lua require'jdtls'.test_class()<CR>
nnoremap <leader>dn <Cmd>lua require'jdtls'.test_nearest_method()<CR>

" ultisnips
autocmd BufWritePost *.snippets :CmpUltisnipsReloadSnippets
