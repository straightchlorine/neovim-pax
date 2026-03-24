return {
  "akinsho/git-conflict.nvim",
  event = "BufReadPost",
  keys = {
    { "<leader>gx", "<cmd>GitConflictListQf<cr>", desc = "git-conflict: list all conflicts" },
  },
  opts = {
    default_mappings = {
      ours = "co",
      theirs = "ct",
      none = "c0",
      both = "cb",
      next = "]x",
      prev = "[x",
    },
    default_commands = true,
    disable_diagnostics = true,
    list_opener = "copen",
    highlights = {
      incoming = "DiffAdd",
      current = "DiffText",
    },
  },
}
