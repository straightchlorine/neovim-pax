return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		},
		"nvim-tree/nvim-web-devicons",
		"folke/trouble.nvim",
		"folke/todo-comments.nvim",
		"rmagatti/session-lens",
	},
	config = function()
		local telescope = require("telescope")
		local open_with_trouble = require("trouble.sources.telescope").open
		local add_to_trouble = require("trouble.sources.telescope").add

		-- TODO: should look more into transform_mod and actions
		telescope.setup({
			defaults = {
				mappings = {
					i = { ["<c-t>"] = open_with_trouble, ["<c-a>"] = add_to_trouble },
					n = { ["<c-t>"] = open_with_trouble },
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("notify")

		local keymap = vim.keymap

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope: find files" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "telescope: find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "telescope: find string" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "telescope: string under cursor" })
		keymap.set("n", "<leader>fgc", "<cmd>Telescope git_commits<cr>", { desc = "telescope: git commits" })

		keymap.set("n", "<leader>fmm", "<cmd>Telescope keymaps<cr>", { desc = "telescope: keymaps" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "telescope: todo" })
	end,
}
