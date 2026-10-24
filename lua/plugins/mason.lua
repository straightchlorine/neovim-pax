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
        "clangd",
        "tailwindcss",
        "emmet_ls",
        "cssls",
        "html",
        "jsonls",
        "eslint",
        "vtsls",
        "vue_ls",
        "lemminx",
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
        "clang-format",
        "cpplint",
        -- pinned: Spotless in Java projects uses the same version, and 1.37+ does not run on Java 21
        { "google-java-format", version = "v1.36.1" },
      },
      auto_update = false,
      run_on_start = false,
    })
  end,
}
