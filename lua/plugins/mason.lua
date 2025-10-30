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
      automatic_enable = false,  -- Prevent automatic LSP client attachment
      ensure_installed = {
        "lua_ls",
        "pyright",  -- Keep for installation but won't auto-attach
        "ruff",     -- Keep for installation but won't auto-attach
        -- Frontend language servers
        "ts_ls",                  -- TypeScript/JavaScript
        "tailwindcss",           -- Tailwind CSS
        "emmet_ls",              -- Emmet for HTML/CSS
        "cssls",                 -- CSS language server
        "html",                  -- HTML language server
        "jsonls",                -- JSON language server
        "eslint",                -- ESLint language server
        "vuels",                 -- Vue language server (if using Vue)
        "svelte",                -- Svelte language server (if using Svelte)
        "astro",                 -- Astro language server (if using Astro)
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier",
        "prettierd",        -- Faster prettier daemon
        "stylua",
        "ruff",             -- Ruff for Python linting/formatting (CLI tool only)
        "debugpy",
        -- Frontend tools
        "eslint_d",         -- ESLint daemon for faster linting
        "stylelint",        -- CSS/SCSS linting
      },
      auto_update = true,
      run_on_start = true,
    })
  end,
}
