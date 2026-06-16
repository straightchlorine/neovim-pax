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

keymap.set("n", "<A-,>", "<cmd>bprevious<CR>", { desc = "buffer: move to previous buffer" })
keymap.set("n", "<A-.>", "<cmd>bnext<CR>", { desc = "buffer: move to next buffer" })

keymap.set("t", "<C-Space>", "<C-\\><C-n>", { desc = "terminal: exit terminal mode" })

-- Copy paths to the system clipboard.
local function yank_path(expr)
  return function()
    local val = vim.fn.expand(expr)
    if val == "" then
      vim.notify("No path for " .. expr, vim.log.levels.WARN)
      return
    end
    vim.fn.setreg("+", val)
    vim.notify("Copied: " .. val)
  end
end

keymap.set("n", "<leader>yp", yank_path("%:p"), { desc = "yank: absolute file path" })
keymap.set("n", "<leader>yr", yank_path("%:."), { desc = "yank: relative file path" })
keymap.set("n", "<leader>yn", yank_path("%:t"), { desc = "yank: file name" })
keymap.set("n", "<leader>yd", yank_path("%:p:h"), { desc = "yank: parent directory" })
keymap.set("n", "<leader>yf", yank_path("<cfile>"), { desc = "yank: path under cursor" })

-- Navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "window: focus left" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "window: focus down" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "window: focus up" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "window: focus right" })

-- From a terminal, <C-w>+motion leaves insert and moves
for _, key in ipairs({ "h", "j", "k", "l", "q", "w" }) do
  keymap.set("t", "<C-w>" .. key, "<C-\\><C-n><C-w>" .. key, { desc = "window: " .. key .. " from terminal" })
end

-- Resize the focused window
keymap.set("n", "<A-h>", "<cmd>vertical resize -3<CR>", { desc = "window: shrink width" })
keymap.set("n", "<A-l>", "<cmd>vertical resize +3<CR>", { desc = "window: grow width" })
keymap.set("n", "<A-j>", "<cmd>resize -2<CR>", { desc = "window: shrink height" })
keymap.set("n", "<A-k>", "<cmd>resize +2<CR>", { desc = "window: grow height" })
