-- neogit
-- https://github.com/NeogitOrg/neogit

return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "esmuellert/codediff.nvim",
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "neogit: open status" },
    { "<leader>ga", function()
      local file = vim.api.nvim_buf_get_name(0)
      if file == "" then
        vim.notify("No file in buffer", vim.log.levels.WARN)
        return
      end
      local out = vim.fn.system({ "git", "add", "--", file })
      if vim.v.shell_error ~= 0 then
        vim.notify("git add failed: " .. out, vim.log.levels.ERROR)
        return
      end
      vim.notify("git add: " .. vim.fn.fnamemodify(file, ":."), vim.log.levels.INFO)
      pcall(function() require("gitsigns").refresh() end)
      pcall(function() require("neogit").refresh() end)
    end, desc = "git: add current file (whole buffer)" },
    { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "neogit: commit" },
    { "<leader>gC", function()
      vim.cmd("split | terminal git commit --no-verify")
    end, desc = "neogit: commit (no-verify)" },
    { "<leader>gp", "<cmd>Neogit pull<cr>", desc = "neogit: pull" },
    { "<leader>gP", "<cmd>Neogit push<cr>", desc = "neogit: push" },
    { "<leader>gf", "<cmd>Neogit fetch<cr>", desc = "neogit: fetch" },
    { "<leader>go", function()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "NeogitConsole" then
          vim.api.nvim_set_current_win(win)
          return
        end
      end
      vim.notify("No Neogit console open", vim.log.levels.WARN)
    end, desc = "neogit: focus console" },
    { "<leader>gl", "<cmd>Neogit log<cr>", desc = "neogit: log" },
    { "<leader>gn", "<cmd>Neogit branch<cr>", desc = "neogit: branch" },
    { "<leader>gm", "<cmd>Neogit merge<cr>", desc = "neogit: merge" },
    { "<leader>gr", "<cmd>Neogit rebase<cr>", desc = "neogit: rebase" },
  },
  config = function()
    require("neogit").setup({
      integrations = {
        telescope = false,
        codediff = true,
      },
      diff_viewer = "codediff",
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
