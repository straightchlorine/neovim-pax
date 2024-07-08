return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				javascript = { { "prettierd", "prettier" } },
				latex = { "texlab", "latexindent", "bibtex-tidy" },
				python = { "ruff_format", "flake8" },
				sql = { "sql-formatter" },
				lua = { "stylua" },
				cpp = { "cpplint" },
				c = { "cpplint" },
				-- TODO: add other languages along with new projects
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
