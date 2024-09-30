return {
	"vim-test/vim-test",
	config = function()
		vim.g["test#strategy"] = {
			nearest = "toggleterm",
			file = "dispatch",
			suite = "basic",
		}

		-- TODO: neotest-vim-test

		-- vim.keymap.set("n", "<leader>t", "<Cmd>TestNearest<CR>", { desc = "vim-test: test nearest" })
		-- vim.keymap.set("n", "<leader>T", "<Cmd>TestFile<CR>", { desc = "vim-test: test file" })
		-- vim.keymap.set("n", "<leader>a", "<Cmd>TestSuite<CR>", { desc = "vim-test: test suite" })
		-- vim.keymap.set("n", "<leader>l", "<Cmd>TestLast<CR>", { desc = "vim-test: test last" })
		-- vim.keymap.set("n", "<leader>g", "<Cmd>TestVisit<CR>", { desc = "vim-test: test visit" })
	end,
}
