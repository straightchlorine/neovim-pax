return {
	"vim-test/vim-test",
	config = function()
		vim.g["test#strategy"] = {
			nearest = "toggleterm",
			file = "dispatch",
			suite = "basic",
		}

		vim.keymap.set("n", "<leader>t", "<Cmd>TestNearest<CR>")
		vim.keymap.set("n", "<leader>ts", "<Cmd>TestNearest<CR>")
		vim.keymap.set("n", "<leader>T", "<Cmd>TestFile<CR>")
		vim.keymap.set("n", "<leader>a", "<Cmd>TestSuite<CR>")
		vim.keymap.set("n", "<leader>l", "<Cmd>TestLast<CR>")
		vim.keymap.set("n", "<leader>g", "<Cmd>TestVisit<CR>")
	end,
}
