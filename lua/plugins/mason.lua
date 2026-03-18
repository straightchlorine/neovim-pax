-- mason.nvim
-- https://github.com/williamboman/mason.nvim

return {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "MasonLog" },
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
      automatic_enable = false,
      ensure_installed = {
        "lua_ls",
        "pyright",
        "ruff",
        "gopls",
        "tailwindcss",
        "emmet_ls",
        "cssls",
        "html",
        "jsonls",
        "eslint",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier",
        "prettierd",
        "stylua",
        "ruff",
        "debugpy",
        "eslint_d",
        "stylelint",
        "csharpier",
        "netcoredbg",
      },
      auto_update = false,
      run_on_start = false,
    })
  end,
}
