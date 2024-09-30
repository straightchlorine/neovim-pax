return {
	"smoka7/hop.nvim",
	version = "*",
	opts = {
		keys = "etovxqpdygfblzhckisuran",
		multi_windows = true,
	},
	config = function()
		require("hop").setup()
		vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true, noremap = true })
		vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true, noremap = true })
		vim.api.nvim_set_keymap("n", "f", ":HopChar1CurrentLine<cr>", { silent = true, noremap = true })
		vim.api.nvim_set_keymap("n", "F", ":HopWordCurrentLine<cr>", { silent = true, noremap = true })
		vim.api.nvim_set_keymap("n", "t", ":HopChar1<cr>", { silent = true, noremap = true })
		vim.api.nvim_set_keymap("n", "T", ":HopLine<cr>", { silent = true, noremap = true })
	end,
}
