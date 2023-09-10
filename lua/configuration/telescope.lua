--- telescope.lua
-- Configuration for telescope.nvim plugin.
---

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = { },
  extensions = { }
}
