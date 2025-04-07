-- markdown-preview.nvim
-- https://github.com/iamcco/markdown-preview.nvim

return {
  "iamcco/markdown-preview.nvim",
  dependencies = {
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {},
      dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    },
  },
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
}
