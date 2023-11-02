--- tree.lua
-- Configuration for nvim-tree plugin.
---

require('nvim-tree').setup({
  sort_by = 'case_sensitive',
  view = {
    width = 40,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
