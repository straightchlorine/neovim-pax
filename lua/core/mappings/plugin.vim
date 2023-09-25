""" plugin.vim
" Plugin related key mappings.
"""

" nvim-tree
nnoremap <leader>nt <cmd>NvimTreeToggle<cr>
nnoremap <leader>nf <cmd>NvimTreeFindFile<cr>

" telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" bufferline
nnoremap <leader>[b <cmd>BufferLineCycleNext<cr>
nnoremap <leader>]b <cmd>BufferLineCyclePrev<cr>

" vim-oscyank
nmap <leader>c <Plug>OSCYankOperator
nmap <leader>cc <leader>c_
vmap <leader>c <Plug>OSCYankVisual

" vim-flog
nnoremap <leader>gb <cmd>Flog<cr>
