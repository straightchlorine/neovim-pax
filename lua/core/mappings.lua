--- mappings.lua
-- Contains all user defined mappings.
---

vim.cmd('source $HOME/.config/nvim/lua/core/mappings/general.vim')
vim.cmd('source $HOME/.config/nvim/lua/core/mappings/plugin.vim')

-- nvim-ufo
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

require('core.handles')
