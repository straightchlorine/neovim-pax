-- auto-session
-- https://github.com/rmagatti/auto-session

return {
	"rmagatti/auto-session",
	lazy = false,
	keys = {
		{ "<leader>wr", "<cmd>SessionSearch<CR>", desc = "Session search" },
		{ "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session" },
		{ "<leader>wa", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
		{ "<leader>wd", "<cmd>SessionDelete<CR>", desc = "Delete session" },
		{ "<leader>wl", "<cmd>SessionRestore<CR>", desc = "Load last session" },
	},

	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		log_level = "error",
		auto_session_suppress_dirs = { "~/", "~/Downloads" },
		auto_save_enabled = true,
		auto_restore_enabled = false,
		auto_session_use_git_branch = true,
		session_lens = {
			load_on_setup = true,
			previewer = true,
			mappings = {
				delete_session = { "i", "<C-D>" },
				alternate_session = { "i", "<C-S>" },
				copy_session = { "i", "<C-Y>" },
			},
			theme_conf = {
				border = true,
			},
		},
	},
}
