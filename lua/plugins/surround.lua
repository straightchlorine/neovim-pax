return {
	"kylechui/nvim-surround",
	event = { "BufReadPre", "BufNewFile" },
	version = "*",
	config = function()
		require("nvim-surround").setup()
		local surround = require("nvim-surround")
		surround.setup()

		-- TODO: add some more mappings for latex
	end,
}
