--- bufferline.lua
-- Configuration for bufferline.nvim plugin
---

require('bufferline').setup {
  options = {
    mode = "buffers",
    themable = true,
    numbers = 'both',
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    left_mouse_command = "buffer %d",
    middle_mouse_command = nil,
    indicator = {
      icon = '▎',
      style = 'icon',
    },
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    max_prefix_length = 15,
    truncate_names = true,
    tab_size = 18,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
        return "("..count..")"
    end,
    custom_filter = function(buf_number, buf_numbers)
      -- excluded buffers
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = function()
          return vim.fn.getcwd()
        end,
        text_align = "left",
        separator = true
      }
    },
    color_icons = true,
    get_element_icon = function(element)
      local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(opts.filetype, { default = false })
      return icon, hl
    end,
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = true,
    show_duplicate_prefix = true,
    persist_buffer_sort = true,
    separator_style = "thin",
    enforce_regular_tabs = true,
    always_show_bufferline = true,
    hover = {
      enabled = true,
      delay = 200,
      reveal = {'close'}
    },
    sort_by = function(buffer_a, buffer_b)
      return buffer_a.modified > buffer_b.modified
    end
  }
}
