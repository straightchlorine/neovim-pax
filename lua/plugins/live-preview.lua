-- live-preview.nvim
-- https://github.com/brianhuster/live-preview.nvim

return {
  "brianhuster/live-preview.nvim",
  cmd = "LivePreview",
  keys = {
    { "<leader>mp", "<cmd>LivePreview start<cr>", ft = "markdown", desc = "markdown: preview in browser" },
    { "<leader>mP", "<cmd>LivePreview close<cr>", ft = "markdown", desc = "markdown: close preview" },
  },
}
