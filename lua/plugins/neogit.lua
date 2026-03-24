-- neogit
-- https://github.com/NeogitOrg/neogit

return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "neogit: open status" },
    { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "neogit: commit" },
    { "<leader>gC", function()
      vim.cmd("split | terminal git commit --no-verify")
    end, desc = "neogit: commit (no-verify)" },
    { "<leader>gp", "<cmd>Neogit pull<cr>", desc = "neogit: pull" },
    { "<leader>gP", "<cmd>Neogit push<cr>", desc = "neogit: push" },
    { "<leader>gf", "<cmd>Neogit fetch<cr>", desc = "neogit: fetch" },
    { "<leader>gl", "<cmd>Neogit log<cr>", desc = "neogit: log" },
    { "<leader>gn", "<cmd>Neogit branch<cr>", desc = "neogit: branch" },
    { "<leader>gm", "<cmd>Neogit merge<cr>", desc = "neogit: merge" },
    { "<leader>gr", "<cmd>Neogit rebase<cr>", desc = "neogit: rebase" },
  },
  config = function()
    require("neogit").setup({
      integrations = {
        telescope = false,
        diffview = true,
      },
      graph_style = "unicode",
      auto_refresh = true,
      filewatcher = {
        enabled = true,
      },
      remember_settings = true,
      use_per_project_settings = true,
      commit_editor = {
        kind = "split",
        show_staged_diff = true,
      },
      console_timeout = 2000,
      auto_show_console = true,
      show_head_commit_hash = true,
      status = {
        recent_commit_count = 10,
      },
    })
  end,
}
