-- nvim-lint
-- https://github.com/mfussenegger/nvim-lint

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "folke/trouble.nvim",
  },
  config = function()
    local lint = require("lint")

    -- linters by ft
    lint.linters_by_ft = {
      markdown = { "vale" },
      c = { "cpplint" },
      cpp = { "cpplint" },
      arduino = { "cpplint" },
      git = { "gitlint" },
      lua = { "luacheck", "selene" },
      python = { "flake8", "mypy", "pylint" },
      json = { "jsonlint" },
      yaml = { "yamllint" },
      vhdl = { "ghdl" },
      html = { "tidy" },
      css = { "stylelint" },
      javascript = { "eslint" },
      typescript = { "eslint" },
      verilog = { "verilator" },
      sql = { "sqlfluff" },
      tex = { "chktex" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      zsh = { "shellcheck" },
      go = { "golangcilint" },
      rust = { "cargo" },
    }

    -- specific settings for linters
    lint.linters.luacheck.args = {
      "--globals",
      "vim",
      "describe",
      "it",
      "before_each",
      "after_each",
      "--no-max-line-length",
    }

    lint.linters.flake8.args = {
      "--max-line-length=100",
      "--ignore=E203,W503",
    }

    -- if file is too large, skip linting
    local function is_file_too_large(bufnr)
      local max_filesize = 100 * 1024 -- max 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
      if ok and stats and stats.size > max_filesize then
        return true
      end
      return false
    end

    -- debouncing
    local lint_augroup = vim.api.nvim_create_augroup("Linting", { clear = true })
    local timer = nil
    local debounce_ms = 300

    -- schedule linting
    local function schedule_lint()
      if timer then
        timer:stop()
      end

      timer = vim.defer_fn(function()
        local bufnr = vim.api.nvim_get_current_buf()

        -- skip linting for large files
        if is_file_too_large(bufnr) then
          local msg = "File too large, linting skipped"
          vim.notify(msg, vim.log.levels.INFO, { title = "nvim-lint" })
          return
        end

        -- ensure buffer is valid
        if vim.api.nvim_buf_is_valid(bufnr) then
          require("lint").try_lint(nil, { bufnr = bufnr })
        end
      end, debounce_ms)
    end

    -- autocommands for linting
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" }, {
      group = lint_augroup,
      callback = schedule_lint,
    })

    -- manual control over the process
    vim.api.nvim_create_user_command("LintStop", function()
      vim.api.nvim_clear_autocmds({ group = lint_augroup })
      vim.notify("Linting stopped", vim.log.levels.INFO, { title = "nvim-lint" })
    end, {})

    vim.api.nvim_create_user_command("LintStart", function()
      vim.api.nvim_clear_autocmds({ group = lint_augroup })

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" }, {
        group = lint_augroup,
        callback = schedule_lint,
      })

      vim.notify("Linting started", vim.log.levels.INFO, { title = "nvim-lint" })
      schedule_lint()
    end, {})

    vim.api.nvim_create_user_command("LintNow", function()
      require("lint").try_lint()
      vim.notify("Linting triggered manually", vim.log.levels.INFO, { title = "nvim-lint" })
    end, {})

    -- run initial lint
    schedule_lint()
  end,
}
