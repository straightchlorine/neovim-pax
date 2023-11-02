--- ibl.lua
-- Configuration for indent-blankline.nvim plugin
---

require ('ibl').setup{
  debounce = 100,
  indent = { char = '┊' },
  whitespace = {
    highlight = { 'Whitespace', 'NonText' },
  },
}

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
