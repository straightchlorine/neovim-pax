return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-neotest/neotest-python",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				-- NOTE: works for pytest only
				require("neotest-python")({
					args = { "-v", "--log-level", "DEBUG" },
				}),
			},
		})
	end,
	keys = {
		{ "<A-t>", "<CMD>Neotest summary toggle<CR>", desc = "neotest: toggle" },
		{ "<leader>tr", "<CMD>Neotest run<CR>", desc = "neotest: test nearest" },
		{ "<leader>ts", "<CMD>Neotest stop<CR>", desc = "neotest: test stop" },
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "neotest: test file",
		},
		{
			"<leader>td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "neotest: test debug",
		},
		{
			"<leader>tw",
			function()
				require("neotest").watch.toggle()
			end,
			desc = "neotest: watch tests",
		},
		{
			"<leader>twf",
			function()
				require("neotest").watch.toggle(vim.fn.expand("%"))
			end,
			desc = "neotest: watch tests",
		},
	},
}
