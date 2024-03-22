""" general.vim
" General key mappings.
"""

" navigation between windows in all modes
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" splitting
nnoremap <leader>vv <cmd>vsplit<cr>
nnoremap <leader>hh <cmd>split<cr>

" terminal mode
tnoremap <Esc> <C-\><C-n>

" simple resizing
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 7/5)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 4/5)<CR>
