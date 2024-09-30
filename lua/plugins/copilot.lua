return {
	"zbirenbaum/copilot-cmp",
	dependencies = {
		"zbirenbaum/copilot.lua",
	},
	config = function()
		local copilot = require("copilot")
		copilot.setup({
			suggestion = { enabled = false },
			panel = { enabled = false },
			filetypes = {
				markdown = true,
				gitcommit = true,
			},
		})

		require("copilot_cmp").setup()
	end,
}
