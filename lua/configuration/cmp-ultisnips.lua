--- cmp-ultisnips.lua
-- Configuration for cmp-nvim-ultisnips.
---

require('cmp_nvim_ultisnips').setup {
  filetype_source = 'treesitter',
  show_snippets = 'all',
  documentation = function(snippet)
    return snippet.description .. '\n\n' .. snippet.value
  end
}

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
