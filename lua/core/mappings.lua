local keymap = vim.keymap

-- Help windows open vertically
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "help" then
      vim.cmd("wincmd L")
      vim.cmd("vertical resize 80")
    end
  end,
})

vim.api.nvim_create_user_command("LowercaseHeadings", function()
  vim.cmd([[silent %s/^\s*\(#\+\s\)\([A-Z]\)/\=submatch(1) . tolower(submatch(2))/]])
end, { desc = "Lowercase first letter after Markdown headings" })

keymap.set("n", "<leader>vv", "<C-w>v", { desc = "split: window vertically" })
keymap.set("n", "<leader>hh", "<C-w>s", { desc = "split: window horizontally" })

keymap.set("n", "<leader>tbo", "<cmd>tabnew<CR>", { desc = "tab: open new tab" })
keymap.set("n", "<leader>tbx", "<cmd>tabclose<CR>", { desc = "tab: close current tab" })
keymap.set("n", "<leader>tbn", "<cmd>tabn<CR>", { desc = "tab: go to next tab" })
keymap.set("n", "<leader>tbp", "<cmd>tabp<CR>", { desc = "tab: go to previous tab" })
keymap.set("n", "<leader>tbf", "<cmd>tabnew %<CR>", { desc = "tab: open current buffer in new tab" })

keymap.set("n", "<A-,>", "<cmd>bprevious<CR>", { desc = "buffer: move to previous buffer" })
keymap.set("n", "<A-.>", "<cmd>bnext<CR>", { desc = "buffer: move to next buffer" })
