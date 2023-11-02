--- telescope.lua
-- Configuration for telescope.nvim plugin.
---

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ['<C-h>'] = 'which_key'
      }
    }
  },
}

require('telescope').load_extension('notify')
require('telescope').extensions.dap.configurations()

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
