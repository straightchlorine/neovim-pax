--- tree.lua
-- Configuration for nvim-tree plugin
---

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 32,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})
