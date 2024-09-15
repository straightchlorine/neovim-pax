return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				javascript = { "prettierd", "prettier" },
				tex = { "latexindent", "bibtex-tidy" },
				python = { "ruff_format", "autoflake" },
				sql = { "sql-formatter" },
				lua = { "stylua" },
				sh = { "beautysh" },
				zsh = { "beautysh" },
				cpp = { "clang-format" },
				c = { "clang-format" },
				arduino = { "clang-format" },
				asm = { "asmfmt" },
				rust = { "rustfmt" },
				yaml = { "yamlfmt" },
				xml = { "xmllint" },
				java = { "google-java-format" },
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
