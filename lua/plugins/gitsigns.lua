return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
			end

			map("n", "]h", gs.next_hunk, "next hunk")
			map("n", "[h", gs.prev_hunk, "prev hunk")

			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "select hunk")

			map("n", "<leader>hs", gs.stage_hunk, "stage hunk")
			map("n", "<leader>hp", gs.preview_hunk, "preview hunk")
			map("n", "<leader>hu", gs.undo_stage_hunk, "undo stage hunk")

			map("n", "<leader>hS", gs.stage_buffer, "stage buffer")
			map("n", "<leader>hR", gs.reset_buffer, "reset buffer")
			map("n", "<leader>hr", gs.reset_hunk, "reset hunk")

			map("v", "<leader>hs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "stage hunk")

			map("v", "<leader>hr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "reset hunk")

			map("n", "<leader>hB", gs.toggle_current_line_blame, "toggle blame")

			map("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end, "blame")

			map("n", "<leader>hd", gs.diffthis, "diff")

			map("n", "<leader>hD", function()
				gs.diffthis("~")
			end, "diff ~")
		end,
	},
}
