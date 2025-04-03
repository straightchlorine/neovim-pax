-- nvim-colorizer.lua
-- https://github.com/norcalli/nvim-colorizer.lua

return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		local ok, colorizer = pcall(require, "colorizer")
		if not ok then
			return
		end

		colorizer.setup({
			filetypes = { "css", "javascript", "html", "lua", "vim", "markdown", "tex", "python", "json" },
			user_default_options = {
				RGB = true,
				RRGGBB = true,
				names = true,
				RRGGBBAA = true,
				rgb_fn = true,
				hsl_fn = true,
				css = true,
				css_fn = true,
				mode = "background",
			},
		})
	end,
}
