--- mappings.lua
-- Contains all user defined mappings.
---

vim.cmd('source $HOME/.config/nvim/lua/core/mappings/general.vim')
vim.cmd('source $HOME/.config/nvim/lua/core/mappings/plugin.vim')

-- nvim-ufo
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

-- nvim-hlslens
local kopts = {noremap = true, silent = true}

vim.api.nvim_set_keymap('n', 'n',
  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
  kopts
)

vim.api.nvim_set_keymap('n', 'N',
  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
  kopts
)

vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>noh<CR>', kopts)

require('core.handles')

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
