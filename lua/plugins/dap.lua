--- Load telescope dap extension and set mappings
local function dap_telescope()
	local telescope = require("telescope")
	local keymap = vim.keymap

	telescope.load_extension("dap")
	keymap.set("n", "<leader>dd", "<cmd>:Telescope dap commands<cr>", { desc = "debug: commands" })
	keymap.set("n", "<leader>dc", "<cmd>:Telescope dap configurations<cr>", { desc = "debug: list configs" })
	keymap.set(
		"n",
		"<leader>dl",
		"<cmd>:Telescope extensions dap list_breakpoints<cr>",
		{ desc = "debug: list breakpoints" }
	)
	keymap.set("n", "<leader>dv", "<cmd>:Telescope dap variables<cr>", { desc = "debug: list variables" })
	keymap.set("n", "<leader>df", "<cmd>:Telescope dap frames<cr>", { desc = "debug: list frames" })
end

--- Set dap and dap-ui mappings
local function dap_mappings()
	local dap = require("dap")

	local keymap = vim.keymap
	keymap.set("n", "<F5>", function()
		dap.continue()
	end, { desc = "debug: continue" })
	keymap.set("n", "<F10>", function()
		dap.step_over()
	end, { desc = "debug: step over" })
	keymap.set("n", "<F11>", function()
		dap.step_into()
	end, { desc = "debug: step into" })
	keymap.set("n", "<F12>", function()
		dap.step_out()
	end, { desc = "debug: step out" })
	keymap.set("n", "<Leader>b", function()
		dap.toggle_breakpoint()
	end, { desc = "debug: toggle breakpoint" })
	keymap.set("n", "<Leader>B", function()
		dap.set_breakpoint()
	end, { desc = "debug: set breakpoint" })
	keymap.set("n", "<Leader>lp", function()
		dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
	end, { desc = "debug: breakpoint + log" })
	keymap.set("n", "<Leader>dr", function()
		dap.repl.open()
	end, { desc = "debug: repl" })
	keymap.set("n", "<Leader>rr", function()
		dap.run_last()
	end, { desc = "debug: restart" })
	keymap.set({ "n", "v" }, "<Leader>dp", function()
		require("dap.ui.widgets").preview()
	end, { desc = "debug: preview" })

	-- dap-ui; setup as well as triggers for opening and closing
	local dapui = require("dapui")
	dapui.setup()

	keymap.set("n", "<Leader>dk", function()
		dapui.eval()
	end, { desc = "debug: ui eval" })
	dap.listeners.before.attach.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
		dapui.close()
	end
	dap.listeners.before.event_exited.dapui_config = function()
		dapui.close()
	end
end

--TODO: Maybe move those two functions into separate file for clarity

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"mfussenegger/nvim-dap-python",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-jdtls",
		"nvim-telescope/telescope-dap.nvim",
	},
	config = function()
		-- BUG: handle it more elegantly, this throws an error at the start when
		-- .venv is not activated; that applies when utilising a different language
		-- should do a proper function, chechking whether the language of the buffer
		-- is actually python, so that user can see the warnings and errors that
		-- are serious
		pcall(function()
			require("dap-python").setup(os.getenv("VIRTUAL_ENV") .. "/bin/python")
		end)

		dap_telescope()
		dap_mappings()
	end,
}
