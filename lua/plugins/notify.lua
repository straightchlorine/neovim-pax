return {
	"rcarriga/nvim-notify",
	config = function()
		local notification = require("notify")
		vim.notify = notification
	end,
}
