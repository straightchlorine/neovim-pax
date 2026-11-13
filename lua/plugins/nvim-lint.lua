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

    lint.linters_by_ft = {
      markdown = { "vale" },
      c = { "cpplint" },
      cpp = { "cpplint" },
      arduino = { "cpplint" },
      lua = { "luacheck" },
      yaml = { "yamllint" },
      vhdl = { "ghdl" },
      html = { "tidy" },
      css = { "stylelint" },
      verilog = { "verilator" },
      sql = { "sqlfluff" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      zsh = { "shellcheck" },
      go = { "golangcilint" },
      rust = { "clippy" },
    }

    -- Vale needs a config; without one it exits with code 2 and nvim-lint shows
    -- "Linter command `vale` exited with code: 2" and a parser error on every save.
    -- Find the project config from the buffer, fall back to a user-level one.
    local function find_vale_config(bufnr)
      local name = vim.api.nvim_buf_get_name(bufnr)
      local dir = name ~= "" and vim.fs.dirname(name) or vim.fn.getcwd()
      local project = vim.fs.find(".vale.ini", { path = dir, upward = true })[1]
      if project then
        return project
      end

      local home = vim.env.HOME or ""
      for _, candidate in ipairs({
        (vim.env.XDG_CONFIG_HOME or home .. "/.config") .. "/vale/.vale.ini",
        home .. "/.vale.ini",
      }) do
        if vim.uv.fs_stat(candidate) then
          return candidate
        end
      end
    end

    lint.linters.vale.ignore_exitcode = true
    lint.linters.vale.args = {
      "--no-exit",
      "--output",
      "JSON",
      "--ext",
      function()
        return "." .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":e")
      end,
      "--config",
      function()
        return find_vale_config(0) or ""
      end,
    }

    lint.linters.luacheck.args = {
      "--globals",
      "vim",
      "Snacks",
      "describe",
      "it",
      "before_each",
      "after_each",
      "--no-max-line-length",
    }

    local function is_file_too_large(bufnr)
      local max_filesize = 100 * 1024 -- max 100 KB
      local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
      if ok and stats and stats.size > max_filesize then
        return true
      end
      return false
    end

    local lint_augroup = vim.api.nvim_create_augroup("Linting", { clear = true })
    local timer = nil
    local debounce_ms = 300

    local function schedule_lint()
      if timer then
        timer:stop()
      end

      timer = vim.defer_fn(function()
        local bufnr = vim.api.nvim_get_current_buf()

        if is_file_too_large(bufnr) then
          local msg = "File too large, linting skipped"
          vim.notify(msg, vim.log.levels.INFO, { title = "nvim-lint" })
          return
        end

        if vim.api.nvim_buf_is_valid(bufnr) then
          local linters = lint.linters_by_ft[vim.bo[bufnr].filetype]
          if linters and vim.tbl_contains(linters, "vale") and not find_vale_config(bufnr) then
            linters = vim.tbl_filter(function(name)
              return name ~= "vale"
            end, linters)
          end
          require("lint").try_lint(linters, { bufnr = bufnr })
        end
      end, debounce_ms)
    end

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      group = lint_augroup,
      callback = schedule_lint,
    })

    vim.api.nvim_create_user_command("LintStop", function()
      vim.api.nvim_clear_autocmds({ group = lint_augroup })
      vim.notify("Linting stopped", vim.log.levels.INFO, { title = "nvim-lint" })
    end, {})

    vim.api.nvim_create_user_command("LintStart", function()
      vim.api.nvim_clear_autocmds({ group = lint_augroup })

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
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

    schedule_lint()
  end,
}
