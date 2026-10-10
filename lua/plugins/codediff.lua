-- codediff.nvim
-- https://github.com/esmuellert/codediff.nvim

return {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",
  keys = {
    { "<leader>gd", "<cmd>CodeDiff<cr>", desc = "codediff: changed files" },
    { "<leader>gh", "<cmd>CodeDiff history %<cr>", desc = "codediff: file history" },
  },
  opts = {},
}
