return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {},
	config = function()
		local toggleterm = require("toggleterm")
		toggleterm.setup({
			size = 120,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "float",
			close_on_exit = false,
			shell = vim.o.shell,
			float_opts = {
				border = "single",
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		})

		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
		end

		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

		-- sending lines to terminal
		local trim_spaces = true
		vim.keymap.set("v", "<space>s", function()
			require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count })
		end)

		-- additional terminals
		vim.api.nvim_set_keymap(
			"n",
			"<leader><leader>t",
			"<cmd>:ToggleTerm direction=tab<CR>",
			{ noremap = true, silent = true }
		)

		vim.api.nvim_set_keymap(
			"n",
			"<leader>tt",
			"<cmd>:ToggleTerm direction=vertical size=80<CR>",
			{ noremap = true, silent = true }
		)
	end,
}
