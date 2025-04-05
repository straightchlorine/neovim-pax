-- copilot.lua
-- https://github.com/zbirenbaum/copilot.lua

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
				terraform = false,
				sh = function()
					-- disable for .env files
					if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
						return false
					end
					return true
				end,
			},
			copilot_model = "Claude 3.7 Sonnet",
			server_opts_overrides = {
				trace = "verbose",
				settings = {
					listCount = 10,
					inlineSuggestCount = 3,
					timeoutMs = 500,
					debounce = 250,
				},
			},
		})

		require("copilot_cmp").setup({
			method = "getCompletionsCycling",
			formatters = {
				label = require("copilot_cmp.format").format_label_text,
				insert_text = require("copilot_cmp.format").format_insert_text,
				preview = require("copilot_cmp.format").deindent,
			},
			event = { "InsertEnter", "LspAttach" },
			fix_pairs = true,
		})
	end,
}
