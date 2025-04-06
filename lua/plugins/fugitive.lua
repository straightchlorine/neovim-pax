-- vim-fugitive
-- https://github.com/tpope/vim-fugitive

return {
  "tpope/vim-fugitive",
  config = function()
    -- basic operations
    vim.keymap.set("n", "<leader>gs", "<cmd>Git<cr>", { desc = "git: status" })
    vim.keymap.set("n", "<leader>ga", "<cmd>Gwrite<cr>", { desc = "git: add current file" })
    vim.keymap.set("n", "<leader>gr", "<cmd>GRead<cr>", { desc = "git: checkout current file" })

    -- git log
    vim.keymap.set("n", "<leader>fgl", "<cmd>Git log<cr>", { desc = "git: log" })
    vim.keymap.set("n", "<leader>fglf", "<cmd>Git log -p %<cr>", { desc = "git: file history" })

    -- git commit
    vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<cr>", { desc = "git: commit" })
    vim.keymap.set("n", "<leader>gca", "<cmd>Git commit --amend<cr>", { desc = "git: commit amend" })

    -- git diff
    vim.keymap.set("n", "<leader>gd", "<cmd>Gdiffsplit<cr>", { desc = "git: diff" })
    vim.keymap.set("n", "<leader>gds", "<cmd>Git diff --staged<cr>", { desc = "git: diff staged" })
  end,
}
