-- mason.nvim
-- https://github.com/williamboman/mason.nvim

return {
  "williamboman/mason.nvim",
  lazy = false,
  priority = 1000,
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      automatic_installation = true,
      ensure_installed = {
        "lua_ls",
        "pyright",  -- Pyright as the Python language server
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier",
        "stylua",
        "ruff",  -- Ruff for Python linting/formatting (used via LSP server)
        "debugpy",
      },
      auto_update = true,
      run_on_start = true,
    })
  end,
}
