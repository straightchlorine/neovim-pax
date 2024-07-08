return {
	"stevearc/vim-arduino",
	ft = "arduino",
	config = function()
		local keymap = vim.keymap

		keymap.set("n", "<leader>aa", "<cmd>ArduinoAttach<CR>", { desc = "arduino: attach" })
		keymap.set("n", "<leader>av", "<cmd>ArduinoVerify<CR>", { desc = "arduino: verify" })
		keymap.set("n", "<leader>au", "<cmd>ArduinoUpload<CR>", { desc = "arduino: upload" })
		keymap.set("n", "<leader>aus", "<cmd>ArduinoUploadAndSerial<CR>", { desc = "arduino: upload and serial" })
		keymap.set("n", "<leader>as", "<cmd>ArduinoSerial<CR>", { desc = "arduino: serial" })
		keymap.set("n", "<leader>ab", "<cmd>ArduinoChooseBoard<CR>", { desc = "arduino: board" })
		keymap.set("n", "<leader>ap", "<cmd>ArduinoChooseProgrammer<CR>", { desc = "arduino: programmer" })
	end,
}

-- TODO: test this plugin
