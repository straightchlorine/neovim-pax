--- ibl.lua
-- Configuration for indent-blankline.nvim plugin
---

require ('ibl').setup{
  debounce = 100,
  indent = { char = '┊' },
  whitespace = {
    highlight = { "Whitespace", "NonText" },
  },
}
