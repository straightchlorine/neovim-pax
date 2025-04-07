-- which-key.nvim
-- https://github.com/folke/which-key.nvim

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "which-key",
    },
  },
}
