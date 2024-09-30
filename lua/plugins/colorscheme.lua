return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	dependencies = {
		"norcalli/nvim-base16.lua",
		"navarasu/onedark.nvim",
		"jacoborus/tender.vim",
		"bluz71/vim-moonfly-colors",
		"bluz71/vim-moonfly-colors",
		"savq/melange-nvim",
		"ellisonleao/gruvbox.nvim",
		"kepano/flexoki",
		"mcchrish/vim-no-color-collections",
		"mcchrish/zenbones.nvim",
		"nordtheme/vim",
		"cocopon/iceberg.vim",
	},
	config = function()
		vim.o.background = "dark"
		vim.cmd([[colorscheme gruvbox]])
	end,
}
