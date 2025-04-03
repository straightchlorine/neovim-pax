-- bufferline.nvim
-- https://github.com/akinsho/bufferline.nvim

return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local ok, bufferline = pcall(require, "bufferline")
		if not ok then
			return
		end

		bufferline.setup({
			options = {
				mode = "buffers",
				style_preset = bufferline.style_preset.default,
				themable = true,
				numbers = "both",
				close_command = "bdelete! %d",
				right_mouse_command = "bdelete! %d",
				left_mouse_command = "buffer %d",
				indicator = { icon = "▎", style = "icon" },
				buffer_close_icon = "󰅖",
				modified_icon = "●",
				close_icon = "",
				left_trunc_marker = "",
				right_trunc_marker = "",
				max_name_length = 18,
				max_prefix_length = 15,
				truncate_names = true,
				tab_size = 18,

				-- lsp setup
				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = false,
				diagnostics_update_on_event = true,

				-- excluded filetypes
				custom_filter = function(buf_number, _)
					local excluded_filetypes = {
						qf = true,
						gitcommit = true,
						help = true,
						["dap-preview"] = true,
					}
					return not excluded_filetypes[vim.bo[buf_number].filetype]
				end,

				offsets = {
					{
						filetype = "neotree",
						text = "File Explorer",
						text_align = "center",
						separator = true,
					},
				},

				color_icons = true,
				get_element_icon = function(element)
					local icon, hl =
						require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
					return icon, hl
				end,

				-- display
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				show_tab_indicators = true,
				show_duplicate_prefix = true,
				duplicates_across_groups = true,
				persist_buffer_sort = true,
				move_wraps_at_ends = false,

				-- style
				separator_style = "slope",
				enforce_regular_tabs = false,
				always_show_bufferline = true,
				auto_toggle_bufferline = true,

				-- hover
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},

				-- sorting
				sort_by = "relative_directory",
			},
		})
	end,
}
