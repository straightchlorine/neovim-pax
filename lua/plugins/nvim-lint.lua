return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			markdown = { "vale" },
			c = { "cpplint" },
			cpp = { "cpplint" },
			arduino = { "cpplint" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
