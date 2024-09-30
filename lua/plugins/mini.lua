return {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		require("mini.ai").setup()
		require("mini.bracketed").setup()
		require("mini.bufremove").setup()
		require("mini.clue").setup()
		require("mini.comment").setup()
		require("mini.cursorword").setup()
		require("mini.icons").setup()
		require("mini.pairs").setup()
		require("mini.surround").setup()
		require("mini.trailspace").setup()
	end,
}
