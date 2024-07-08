return {
	"williamboman/mason.nvim",
	lazy = false,
	priority = 1000,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"arduino_language_server",
				"awk_ls",
				"cmake",
				"cssls",
				"html",
				"lua_ls",
				"pyright",
				"ruff",
				"rust_analyzer",
				"texlab",
				"bashls",
				"docker_compose_language_service",
				"dockerls",
				"gopls",
				"gradle_ls",
				"jdtls",
				"julials",
				"marksman",
				"r_language_server",
				"vhdl_ls",
				"vimls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"bash-debug-adapter",
				"cpptools",
				"debugpy",
				"java-debug-adapter",
				"cpplint",
				"ruff",
				"flake8",
				"luacheck",
				"gitlint",
				"asmfmt",
				"stylua",
				"ruff",
				"black",
			},
		})
	end,
}
