--- mappings.lua
-- User defined key mappings
---

local keymap = vim.keymap

-- general
keymap.set("i", "jk", "<ESC>", { desc = "exit insert mode with jk" })
keymap.set("n", "<leader>+", "<C-a>", { desc = "increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "decrement number" })

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
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "close current split" })

-- tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "open current buffer in new tab" })

-- reorder to previous/next
keymap.set("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", { desc = "re-order to previous buffer" })
keymap.set("n", "<A->>", "<Cmd>BufferMoveNext<CR>", { desc = "re-order to next buffer" })

-- switch between buffers
keymap.set("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { desc = "move to previous buffer" })
keymap.set("n", "<A-.>", "<Cmd>BufferNext<CR>", { desc = "move to next buffer" })

keymap.set("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", { desc = "go to buffer 1" })
keymap.set("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", { desc = "go to buffer 2" })
keymap.set("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", { desc = "go to buffer 3" })
keymap.set("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", { desc = "go to buffer 4" })
keymap.set("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", { desc = "go to buffer 5" })
keymap.set("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", { desc = "go to buffer 6" })
keymap.set("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", { desc = "go to buffer 7" })
keymap.set("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", { desc = "go to buffer 8" })
keymap.set("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", { desc = "go to buffer 9" })
keymap.set("n", "<A-0>", "<Cmd>BufferLast<CR>", { desc = "go to last buffer" })

-- pinning
keymap.set("n", "<A-p>", "<Cmd>BufferPin<CR>", { desc = "pin buffer" })

-- closing
keymap.set("n", "<A-c>", "<Cmd>BufferClose<CR>", { desc = "close current buffer" })
keymap.set("n", "<A-v>", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", { desc = "close all but current" })

-- picking
keymap.set("n", "<C-p>", "<Cmd>BufferPick<CR>", { desc = "pick buffer" })

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
