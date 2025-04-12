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
        "pyright",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier",
        "stylua",
        "black",

        "eslint_d",
        "flake8",

        "debugpy",
      },
      auto_update = true,
      run_on_start = true,
    })
  end,
}
