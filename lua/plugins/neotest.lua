-- neotest
-- https://github.com/nvim-neotest/neotest

local NeotestConfig = {}

--- Get Python path using the comprehensive detection from lspconfig
---@return string Python executable path
function NeotestConfig.get_python_path()
  if _G.get_python_path then
    local workspace = vim.fn.getcwd()
    return _G.get_python_path(workspace)
  end

  if vim.env.VIRTUAL_ENV then
    return vim.env.VIRTUAL_ENV .. "/bin/python3"
  end

  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

--- Setup neotest adapters for different languages
---@return table Configured adapters
function NeotestConfig.setup_adapters()
  return {
    -- Python (pytest)
    require("neotest-python")({
      dap = { justMyCode = false },
      args = { "-v", "--log-level", "DEBUG" },
      runner = "pytest",
      python = NeotestConfig.get_python_path,
    }),

    -- Go
    require("neotest-go")({
      experimental = {
        test_table = true,
      },
      args = { "-count=1", "-timeout=60s", "-race", "-cover" },
    }),

    -- Rust
    require("neotest-rust")({
      args = { "--no-capture" },
      dap_adapter = "lldb",
    }),

    -- JavaScript/TypeScript (Jest)
    require("neotest-jest")({
      jestCommand = "npm test --",
      jestConfigFile = "jest.config.js",
      env = { CI = true },
      cwd = function()
        return vim.fn.getcwd()
      end,
    }),

    -- C/C++ (Google Test)
    require("neotest-gtest").setup({}),
  }
end

--- Setup neotest keymaps
function NeotestConfig.setup_keymaps()
  local neotest = require("neotest")
  local keymap = vim.keymap

  -- Test execution
  keymap.set("n", "<leader>tr", function()
    neotest.run.run()
  end, { desc = "neotest: run nearest test" })

  keymap.set("n", "<leader>tf", function()
    neotest.run.run(vim.fn.expand("%"))
  end, { desc = "neotest: run file tests" })

  keymap.set("n", "<leader>td", function()
    neotest.run.run({ strategy = "dap" })
  end, { desc = "neotest: debug nearest test" })

  keymap.set("n", "<leader>tl", function()
    neotest.run.run_last()
  end, { desc = "neotest: run last test" })

  keymap.set("n", "<leader>ts", function()
    neotest.run.stop()
  end, { desc = "neotest: stop tests" })

  -- Test watching
  keymap.set("n", "<leader>tw", function()
    neotest.watch.toggle()
  end, { desc = "neotest: toggle watch mode" })

  keymap.set("n", "<leader>twf", function()
    neotest.watch.toggle(vim.fn.expand("%"))
  end, { desc = "neotest: toggle watch file" })

  -- UI toggles
  keymap.set("n", "<A-t>", function()
    neotest.summary.toggle()
  end, { desc = "neotest: toggle summary" })

  keymap.set("n", "<leader>to", function()
    neotest.output.open({ enter = true })
  end, { desc = "neotest: open output" })

  keymap.set("n", "<leader>tO", function()
    neotest.output_panel.toggle()
  end, { desc = "neotest: toggle output panel" })

  -- Navigation
  keymap.set("n", "<leader>tj", function()
    neotest.jump.next({ status = "failed" })
  end, { desc = "neotest: jump to next failed" })

  keymap.set("n", "<leader>tk", function()
    neotest.jump.prev({ status = "failed" })
  end, { desc = "neotest: jump to prev failed" })
end

--- Main setup function
function NeotestConfig.setup()
  require("neotest").setup({
    adapters = NeotestConfig.setup_adapters(),

    -- Test discovery settings
    discovery = {
      enabled = true,
      concurrent = 8,
    },

    -- Test execution settings
    running = {
      concurrent = true,
    },

    -- UI configuration
    icons = {
      running = "⟳",
      passed = "✓",
      failed = "✗",
      skipped = "⊘",
      unknown = "?",
    },

    -- Output configuration
    output = {
      enabled = true,
      open_on_run = true,
    },

    -- Status indicators
    status = {
      enabled = true,
      virtual_text = true,
      signs = true,
    },

    -- Summary window
    summary = {
      enabled = true,
      expand_errors = true,
      follow = true,
      open = "botright vsplit | vertical resize 50",
      mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        jumpto = "gf",
        run = "r",
        stop = "s",
        attach = "a",
        run_marked = "R",
        debug = "d",
        mark = "m",
        clear_marked = "M",
        clear_target = "t",
        next_failed = "J",
        prev_failed = "K",
      },
    },

    -- Quickfix integration
    quickfix = {
      enabled = true,
      open = false,
    },
  })

  NeotestConfig.setup_keymaps()
end

return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "mfussenegger/nvim-dap",
    -- Language adapters
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-go",
    "rouge8/neotest-rust",
    "nvim-neotest/neotest-jest",
    "alfaix/neotest-gtest",
  },
  config = function()
    NeotestConfig.setup()
  end,
}
