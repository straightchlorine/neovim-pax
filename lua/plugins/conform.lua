-- conform.nvim
-- https://github.com/stevearc/conform.nvim

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    { "<leader>cf", function() require("conform").format({ async = true }) end, desc = "conform: format buffer" },
  },
  opts = {
    formatters_by_ft = {
      javascript = { "prettierd", "prettier" },
      typescript = { "prettierd", "prettier" },
      jsx = { "prettierd", "prettier" },
      tsx = { "prettierd", "prettier" },
      vue = { "prettierd", "prettier" },
      html = { "prettierd", "prettier" },
      css = { "prettierd", "prettier" },
      scss = { "prettierd", "prettier" },
      sass = { "prettierd", "prettier" },
      json = { "prettierd", "prettier" },
      tex = { "latexindent", "bibtex-tidy" },
      python = { "ruff_format" },
      sql = { "sqlfluff", "sql_formatter" },
      lua = { "stylua" },
      sh = { "beautysh" },
      zsh = { "beautysh" },
      cpp = { "clang-format" },
      c = { "clang-format" },
      arduino = { "clang-format" },
      asm = { "asmfmt" },
      rust = { "rustfmt" },
      yaml = { "yamlfmt" },
      -- lemminx (LSP) keeps blank lines and the editor indent; xmllint --format squashed both
      xml = { lsp_format = "prefer" },
      java = { "google-java-format" },
      cs = { "csharpier" },
      go = { "gofumpt", "golines", "goimports-reviser" },
    },

    -- SQL is not formatted on save: hand-aligned seed inserts (data.sql) get split into one value
    -- per line. Format SQL on demand with <leader>cf instead.
    format_on_save = function(bufnr)
      if vim.bo[bufnr].filetype == "sql" then
        return
      end
      return { timeout_ms = 500, lsp_format = "fallback" }
    end,

    -- stop after first success
    format = {
      timeout_ms = 500,
      async = true,
      quiet = false,
      lsp_format = "fallback",
    },

    notify_on_error = true,

    formatters = {
      prettierd = {
        env = {
          PRETTIER_LEGACY_CLI = "1",
        },
        args = { "--stdin-filepath", "$FILENAME" },
      },
      clang_format = {
        prepend_args = { "--style=file" },
      },
      rustfmt = {
        prepend_args = { "--edition=2021" },
      },
      -- AOSP = Google style with 4-space indent, the usual Java/IntelliJ look.
      -- Must match <style>AOSP</style> in the project's Spotless config.
      ["google-java-format"] = {
        prepend_args = { "--aosp" },
      },
    },
  },
}
