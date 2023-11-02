--- fugitive.lua
-- Configuration file for vim-fugitive.
---

-- basic mappings
vim.keymap.set('n', '<leader>gs', '<cmd>Git<cr>', { desc = 'status' })
vim.keymap.set('n', '<leader>gw', '<cmd>Gwrite<cr>', { desc = 'add' })
vim.keymap.set('n', '<leader>gc', '<cmd>Git commit<cr>', { desc = 'commit' })
vim.keymap.set('n', '<leader>gd', '<cmd>Gdiffsplit<cr>', { desc = 'diff' })
vim.keymap.set('n', '<leader>gpl', '<cmd>Git pull<cr>', { desc = 'pull' })
vim.keymap.set('n', '<leader>gpu', '<cmd>15 split|term git push<cr>', { desc = 'push' })

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
