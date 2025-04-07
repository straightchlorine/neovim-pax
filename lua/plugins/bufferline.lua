-- bufferline.nvim
-- https://github.com/akinsho/bufferline.nvim

return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local bufferline = require("bufferline")

    bufferline.setup({
      options = {
        mode = "buffers",
        style_preset = bufferline.style_preset.minimal,
        numbers = "ordinal",
        close_command = function(bufnum)
          require("bufferline").unselect_buffer_by_id(bufnum)
          Snacks.bufdelete(bufnum)
        end,
        right_mouse_command = function(bufnum)
          require("bufferline").unselect_buffer_by_id(bufnum)
          Snacks.bufdelete(bufnum)
        end,
        left_mouse_command = function(bufnum)
          require("bufferline").unselect_buffer_by_id(bufnum)
          vim.api.nvim_set_current_buf(bufnum)
        end,
        indicator = {
          icon = "▎",
          style = "icon",
        },
        buffer_close_icon = "󰅖",
        modified_icon = "●",
        close_icon = " ",
        left_trunc_marker = "",
        right_trunc_marker = "",

        -- lsp setup
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          return "(" .. count .. ")"
        end,

        -- excluded filetypes
        custom_filter = function(buf_number)
          local excluded_filetypes = {
            "qf",
            "gitcommit",
            "help",
            "dap-repl",
            "dapui_console",
            "dapui_watches",
            "dap-terminal",
            "dapui_breakpoints",
            "dapui_stacks",
            "dapui_scopes",
          }

          -- ensure the buffer is not excluded
          local ft = vim.bo[buf_number].filetype
          for _, excluded_ft in ipairs(excluded_filetypes) do
            if ft == excluded_ft then
              return false
            end
          end

          -- ensure the buffer is valid
          if not vim.api.nvim_buf_is_valid(buf_number) then
            return false
          end

          return true
        end,

        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
        color_icons = true,
        get_element_icon = function(element)
          local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
          return icon, hl
        end,

        -- display options
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        enforce_regular_tabs = false,
        persist_buffer_sort = true,
        move_wraps_at_ends = false,

        -- style
        separator_style = "thick",
        always_show_bufferline = true,

        -- sorting
        sort_by = "relative_directory",
      },
      highlights = {
        buffer_selected = {
          bold = true,
          italic = false,
        },
        diagnostic_selected = {
          bold = true,
        },
        info_selected = {
          bold = true,
        },
        info_diagnostic_selected = {
          bold = true,
        },
      },
    })
  end,
}
