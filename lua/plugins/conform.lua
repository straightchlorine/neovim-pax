-- conform.vnim
-- https://github.com/stevearc/conform.nvim

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			desc = "Format buffer",
			mode = { "n", "v" },
		},
	},
	opts = {
		formatters_by_ft = {
			javascript = { "prettierd", "prettier" },
			typescript = { "prettierd", "prettier" },
			jsx = { "prettierd", "prettier" },
			tsx = { "prettierd", "prettier" },
			html = { "prettierd", "prettier" },
			css = { "prettierd", "prettier" },
			json = { "prettierd", "prettier" },
			tex = { "latexindent", "bibtex-tidy" },
			python = { "ruff_format", "autoflake" },
			sql = { "sqlfluff", "sql_formatter" },
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
			go = { "gofumpt", "golines", "goimports-reviser" },
		},

		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},

		-- stop after first success
		format = {
			timeout_ms = 500,
			async = true,
			quiet = false,
			lsp_fallback = true,
		},

		notify_on_error = true,

		formatters = {
			prettierd = {
				env = {
					PRETTIER_LEGACY_CLI = "1",
				},
			},
			clang_format = {
				prepend_args = { "--style=file" },
			},
			rustfmt = {
				prepend_args = { "--edition=2021" },
			},
		},
	},
}
