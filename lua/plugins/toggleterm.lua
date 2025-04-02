-- toggleterm.nvim
-- Configuration for the toggleterm.nvim plugin.
-- https://github.com/akinsho/toggleterm.nvim

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {},
	config = function()
		local toggleterm = require("toggleterm")
		local Terminal = require("toggleterm.terminal").Terminal

		-- plugin setup
		toggleterm.setup({
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
				return 20
			end,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "curved",
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
			winbar = {
				enabled = false,
			},
		})

		-- mappings for the terminal mode
		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			local mappings = {
				["<esc>"] = "<C-\\><C-n>",
				["jk"] = "<C-\\><C-n>",
				["<C-h>"] = "<Cmd>wincmd h<CR>",
				["<C-j>"] = "<Cmd>wincmd j<CR>",
				["<C-k>"] = "<Cmd>wincmd k<CR>",
				["<C-l>"] = "<Cmd>wincmd l<CR>",
				["<C-w>"] = "<C-\\><C-n><C-w>",
			}
			for key, cmd in pairs(mappings) do
				vim.keymap.set("t", key, cmd, opts)
			end
		end
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

		-- custom terminal instances
		local terminals = {
			lazygit = Terminal:new({
				cmd = "lazygit",
				hidden = true,
				direction = "float",
				float_opts = { border = "double" },
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(
						term.bufnr,
						"n",
						"q",
						"<cmd>close<CR>",
						{ noremap = true, silent = true }
					)
				end,
				on_close = function()
					vim.cmd("startinsert!")
				end,
			}),
			python = Terminal:new({
				cmd = "python",
				hidden = true,
				direction = "vertical",
				size = 80,
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(
						term.bufnr,
						"n",
						"q",
						"<cmd>close<CR>",
						{ noremap = true, silent = true }
					)
				end,
				on_close = function()
					vim.cmd("startinsert!")
				end,
			}),
			lua = Terminal:new({
				cmd = "lua",
				hidden = true,
				direction = "vertical",
				size = 80,
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(
						term.bufnr,
						"n",
						"q",
						"<cmd>close<CR>",
						{ noremap = true, silent = true }
					)
				end,
				on_close = function()
					vim.cmd("startinsert!")
				end,
			}),
		}

		-- toggle functions for terminals
		function _G.toggle_lazygit()
			terminals.lazygit:toggle()
		end
		function _G.toggle_python()
			terminals.python:toggle()
		end
		function _G.toggle_lua()
			terminals.lua:toggle()
		end

		-- key mappings
		local keymaps = {
			["<leader>tg"] = "<cmd>lua toggle_lazygit()<CR>",
			["<leader>tp"] = "<cmd>lua toggle_python()<CR>",
			["<leader>tl"] = "<cmd>lua toggle_lua()<CR>",
			["<leader>th"] = "<cmd>ToggleTerm direction=horizontal<CR>",
			["<leader>tv"] = "<cmd>ToggleTerm direction=vertical size=80<CR>",
			["<leader>tt"] = "<cmd>ToggleTerm direction=tab<CR>",
			["<leader>ts"] = ":ToggleTermSendVisualSelection<CR>",
			["<leader>sl"] = ":ToggleTermSendCurrentLine<CR>",
		}

		for key, cmd in pairs(keymaps) do
			vim.api.nvim_set_keymap("n", key, cmd, { noremap = true, silent = true })
		end

		-- separate terminal instances
		for i = 1, 4 do
			vim.api.nvim_set_keymap("n", "<leader>t" .. i, "<cmd>ToggleTerm " .. i .. "<CR>", {
				noremap = true,
				silent = true,
				desc = "Terminal #" .. i,
			})
		end
	end,
}
