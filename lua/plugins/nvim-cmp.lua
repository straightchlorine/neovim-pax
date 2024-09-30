return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-cmdline",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
			config = function()
				local ls = require("luasnip")
				vim.keymap.set({ "i", "s" }, "<C-L>", function()
					ls.jump(1)
				end, { silent = true })
				vim.keymap.set({ "i", "s" }, "<C-J>", function()
					ls.jump(-1)
				end, { silent = true })
			end,
		},
		"saadparwaiz1/cmp_luasnip",
		"windwp/nvim-autopairs",
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
		"zbirenbaum/copilot-cmp",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),
			sources = cmp.config.sources({
				{ name = "copilot", group_index = 1 },
				{ name = "nvim_lsp", group_index = 1 },
				{ name = "nvim_lsp_signature_help", group_index = 1 },
				{ name = "path", group_index = 1 },
				{ name = "luasnip", group_index = 1 },
				{ name = "buffer", gruop_index = 2 },
			}),
			window = {
				documentation = cmp.config.window.bordered(),
			},
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					max_width = 50,
					symbol_map = { Copilot = "" },
				}),
			},
		})

		-- `/` cmdline setup.
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- `:` cmdline setup.
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
		})

		-- adding autopairs
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
