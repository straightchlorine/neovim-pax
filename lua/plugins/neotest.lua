return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-neotest/neotest-python",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				-- BUG: currently works only for pytest, not unittest
				require("neotest-python")({
					args = { "-v", "--log-level", "DEBUG" },
				}),
			},
		})
	end,
	keys = {
		{ "<A-t>", "<CMD>Neotest summary toggle<CR>", desc = "neotest: toggle" },
		{ "<leader>tn", "<CMD>Neotest run<CR>", desc = "neotest: test nearest" },
		{ "<leader>ts", "<CMD>Neotest stop<CR>", desc = "neotest: test stop" },
		{ "<leader>tf", "<CMD>Neotest run file<CR>", desc = "neotest: test file" },
		{
			"<leader>td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "neotest: test debug",
		},
	},
}
