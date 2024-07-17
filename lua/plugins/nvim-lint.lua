return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			markdown = { "vale" },
			c = { "cpplint" },
			cpp = { "cpplint" },
			arduino = { "cpplint" },
			git = { "gitlint" },
			lua = { "luacheck" },
			python = { "flake8" },
			json = { "jsonlint" },
			yaml = { "yamllint" },
			vhdl = { "ghdl" },
			html = { "tidy" },
			verilog = { "verilator" },
			sql = { "sqlfluff" },
			tex = { "chktex" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
