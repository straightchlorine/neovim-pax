return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "diffview: open" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "diffview: file history" },
  },
  opts = {
    keymaps = {
      view = {
        ["<leader>co"] = function()
          require("diffview.config").actions.conflict_choose("ours")
        end,
        ["<leader>ct"] = function()
          require("diffview.config").actions.conflict_choose("theirs")
        end,
        ["<leader>cb"] = function()
          require("diffview.config").actions.conflict_choose("base")
        end,
        ["<leader>ca"] = function()
          require("diffview.config").actions.conflict_choose("all")
        end,
      },
    },
  },
}
