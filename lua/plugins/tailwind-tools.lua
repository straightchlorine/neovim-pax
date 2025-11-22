-- tailwind-tools.nvim
-- https://github.com/luckasRanarison/tailwind-tools.nvim

return {
  "luckasRanarison/tailwind-tools.nvim",
  name = "tailwind-tools",
  build = ":UpdateRemotePlugins",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "neovim/nvim-lspconfig", -- optional
  },
  opts = {
    document_color = {
      enabled = true, -- can be toggled by commands
      kind = "inline", -- "inline" | "foreground" | "background"
      inline_symbol = "●", -- only used in inline mode
      debounce = 200, -- in milliseconds, only applied in insert mode
    },
    conceal = {
      enabled = false, -- can be toggled by commands
      min_length = nil, -- only conceal classes exceeding the provided length
      symbol = "󱏿", -- only a single character is allowed
      highlight = { -- extmark highlight options, see :h 'highlight'
        fg = "#38BDF8",
      },
    },
    custom_filetypes = {}, -- see the extension section to learn how it works
    server = {
      override = false, -- Disable automatic LSP setup to avoid deprecated lspconfig calls
    },
  },
  config = function(_, opts)
    require("tailwind-tools").setup(opts)
  end,
}