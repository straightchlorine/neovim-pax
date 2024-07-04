return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gs", "<cmd>G<cr>", { desc = "git status" })
		vim.keymap.set("n", "<leader>gw", "<cmd>Gwrite<cr>", { desc = "git add" })

		vim.keymap.set("n", "<leader>gl", "<cmd>Gllog<cr>", { desc = "git log" })
		vim.keymap.set("n", "<leader>gd", "<cmd>Gdiffsplit<cr>", { desc = "diff" })

		vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<cr>", { desc = "commit" })
		vim.keymap.set("n", "<leader>gcc", "<cmd>Git commit --amend<cr>", { desc = "commit amend no-edit" })

		vim.keymap.set("n", "<leader>gpl", "<cmd>Git pull<cr>", { desc = "pull" })
		vim.keymap.set("n", "<leader>gpu", "<cmd>15 split|term git push<cr>", { desc = "push" })
	end,
}
