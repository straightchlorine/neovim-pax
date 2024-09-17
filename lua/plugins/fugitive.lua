return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gs", "<cmd>G<cr>", { desc = "git: status" })
		vim.keymap.set("n", "<leader>gw", "<cmd>Gwrite<cr>", { desc = "git: add" })

		vim.keymap.set("n", "<leader>gl", "<cmd>Gllog<cr>", { desc = "git: log" })
		vim.keymap.set("n", "<leader>gdf", "<cmd>Gdiffsplit<cr>", { desc = "git: diff" })

		vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<cr>", { desc = "git: commit" })
		vim.keymap.set("n", "<leader>gcc", "<cmd>Git commit --amend<cr>", { desc = "git: commit amend" })
		vim.keymap.set("n", "<leader>gcn", "<cmd>Git commit --amend --no-edit<cr>", { desc = "git: commit amend" })

		vim.keymap.set("n", "<leader>gpl", "<cmd>Git pull<cr>", { desc = "git: pull" })
		vim.keymap.set("n", "<leader>gpu", "<cmd>15 split|term git push<cr>", { desc = "git: push" })
	end,
}
