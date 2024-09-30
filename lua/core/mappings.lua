--- mappings.lua
-- User defined key mappings
---

local keymap = vim.keymap

-- general
keymap.set("n", "<leader>+", "<C-a>", { desc = "general: increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "general: decrement number" })

-- help opens vertically
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "help" then
			vim.cmd("wincmd L")
			vim.cmd("vertical resize 80")
		end
	end,
})

-- splits
keymap.set("n", "<leader>vv", "<C-w>v", { desc = "split: window vertically" })
keymap.set("n", "<leader>hh", "<C-w>s", { desc = "split: window horizontally" })
keymap.set("n", "<leader>e", "<C-w>=", { desc = "split: equal size" })
keymap.set("n", "<leader>x", "<cmd>close<CR>", { desc = "split: close" })

-- tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "tab: open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "tab: close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "tab: go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "tab: go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "tab: open current buffer in new tab" })

-- reorder to previous/next
keymap.set("n", "<A-<>", "<cmd>BufferLineMovePrev<CR>", { desc = "buffer: re-order to previous buffer" })
keymap.set("n", "<A->>", "<cmd>BufferLineMoveNext<CR>", { desc = "buffer: re-order to next buffer" })

-- switch between buffers
keymap.set("n", "<A-,>", "<cmd>BufferLineCyclePrev<CR>", { desc = "buffer: move to previous buffer" })
keymap.set("n", "<A-.>", "<cmd>BufferLineCycleNext<CR>", { desc = "buffer: move to next buffer" })

keymap.set("n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>", { desc = "buffer: go to buffer 1" })
keymap.set("n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>", { desc = "buffer: go to buffer 2" })
keymap.set("n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>", { desc = "buffer: go to buffer 3" })
keymap.set("n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>", { desc = "buffer: go to buffer 4" })
keymap.set("n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>", { desc = "buffer: go to buffer 5" })
keymap.set("n", "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>", { desc = "buffer: go to buffer 6" })
keymap.set("n", "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>", { desc = "buffer: go to buffer 7" })
keymap.set("n", "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>", { desc = "buffer: go to buffer 8" })
keymap.set("n", "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>", { desc = "buffer: go to buffer 9" })

-- pinning
keymap.set("n", "<A-t>", "<cmd>BufferLineTogglePin<CR>", { desc = "buffer: pin buffer" })

-- closing
keymap.set("n", "<A-c>", "<cmd>BufferLinePickClose<CR>", { desc = "buffer: pick buffer to close" })
keymap.set("n", "<A-v>", "<cmd>BufferLineCloseOthers<CR>", { desc = "buffer: close all but current" })

-- picking
keymap.set("n", "<A-p>", "<cmd>BufferLinePick<CR>", { desc = "buffer: pick buffer" })

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
