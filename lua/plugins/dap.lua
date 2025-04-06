-- nvim-dap and neotest
-- https://github.com/mfussenegger/nvim-dap
-- https://github.com/nvim-neotest/neotest

local DAPConfig = {}

-- virtual text setup
local function setup_virtual_text()
  require("nvim-dap-virtual-text").setup({
    enabled = true,
    enabled_commands = true,
    highlight_changed_variables = true,
    highlight_new_as_changed = false,
    show_stop_reason = true,
    commented = false,
    virt_text_pos = "eol",
    all_frames = false,
    virt_lines = false,
    virt_text_win_col = nil,
  })
end

-- telescope setup
function DAPConfig.setup_telescope()
  local telescope = require("telescope")
  local keymap = vim.keymap

  telescope.load_extension("dap")

  keymap.set("n", "<leader>dd", "<cmd>Telescope dap commands<cr>", { desc = "debug: commands" })
  keymap.set("n", "<leader>dc", "<cmd>Telescope dap configurations<cr>", { desc = "debug: list configs" })
  keymap.set("n", "<leader>dl", "<cmd>Telescope dap list_breakpoints<cr>", { desc = "debug: list breakpoints" })
  keymap.set("n", "<leader>dv", "<cmd>Telescope dap variables<cr>", { desc = "debug: list variables" })
  keymap.set("n", "<leader>df", "<cmd>Telescope dap frames<cr>", { desc = "debug: list frames" })

  keymap.set("n", "<leader>ds", "<cmd>Telescope dap configurations<cr>", { desc = "debug: select configuration" })
end

-- dap-ui configuration
local function setup_dap_ui()
  local dapui = require("dapui")

  dapui.setup({
    icons = {
      expanded = "▾",
      collapsed = "▸",
      current_frame = "→",
    },
    mappings = {
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
    },
    layouts = {
      {
        elements = {
          { id = "scopes", size = 0.25 },
          "breakpoints",
          "stacks",
          "watches",
        },
        size = 40,
        position = "left",
      },
      {
        elements = {
          "repl",
          "console",
        },
        size = 0.25,
        position = "bottom",
      },
    },
    floating = {
      max_height = nil,
      max_width = nil,
      border = "single",
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
    windows = { indent = 1 },
    render = {
      max_type_length = nil,
      max_value_lines = 100,
    },
  })

  return dapui
end

-- mappings setup
function DAPConfig.setup_mappings()
  local dap = require("dap")
  local keymap = vim.keymap
  local dapui = setup_dap_ui()

  -- main debugging controls
  keymap.set("n", "<F5>", dap.continue, { desc = "debug: continue" })
  keymap.set("n", "<F10>", dap.step_over, { desc = "debug: step over" })
  keymap.set("n", "<F11>", dap.step_into, { desc = "debug: step into" })
  keymap.set("n", "<F12>", dap.step_out, { desc = "debug: step out" })

  -- breakpoint controls
  keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "debug: toggle breakpoint" })
  keymap.set("n", "<Leader>B", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
  end, { desc = "debug: conditional breakpoint" })
  keymap.set("n", "<Leader>lp", function()
    dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
  end, { desc = "debug: breakpoint with log" })
  keymap.set("n", "<Leader>cb", dap.clear_breakpoints, { desc = "debug: clear all breakpoints" })

  -- session management
  keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "debug: open REPL" })
  keymap.set("n", "<Leader>rr", dap.run_last, { desc = "debug: run last" })
  keymap.set({ "n", "v" }, "<Leader>dp", function()
    require("dap.ui.widgets").preview()
  end, { desc = "debug: preview" })
  keymap.set({ "n", "v" }, "<Leader>dt", dap.terminate, { desc = "debug: terminate session" })
  keymap.set("n", "<Leader>dR", function()
    dap.restart()
  end, { desc = "debug: restart session" })

  -- dap-ui mappings
  keymap.set("n", "<Leader>dk", dapui.eval, { desc = "debug: evaluate expression" })
  keymap.set("n", "<Leader>du", function()
    dapui.toggle()
  end, { desc = "debug: toggle UI" })
  keymap.set("v", "<Leader>de", dapui.eval, { desc = "debug: evaluate selection" })

  -- dap ui hover
  keymap.set("n", "<Leader>dh", function()
    require("dap.ui.widgets").hover()
  end, { desc = "debug: hover variables" })

  -- opening and closing the ui
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

-- setup debugging adapters
function DAPConfig.setup_languages()
  local dap = require("dap")

  -- python configuration
  local function setup_python()
    local python_path = vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"

    -- try to find venv
    if vim.env.VIRTUAL_ENV then
      python_path = vim.env.VIRTUAL_ENV .. "/bin/python"
    end

    require("dap-python").setup(python_path)
  end

  -- Java configuration via nvim-jdtls
  local function setup_java()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function()
        if pcall(require, "jdtls") then
          vim.keymap.set("n", "<leader>djt", function()
            require("jdtls").test_nearest_method()
          end, { buffer = 0, desc = "debug: java test method" })

          vim.keymap.set("n", "<leader>djc", function()
            require("jdtls").test_class()
          end, { buffer = 0, desc = "debug: java test class" })
        end
      end,
    })
  end

  -- call the setup
  pcall(setup_python)
  pcall(setup_java)

  -- C/C++ configuration
  dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode",
    name = "lldb",
  }

  dap.configurations.cpp = {
    {
      name = "Launch",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
    },
  }

  -- add the same config for c and rust
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp
end

-- neotest setup
function DAPConfig.setup_neotest()
  local neotest = require("neotest")

  neotest.setup({
    adapters = {
      require("neotest-python")({
        args = { "-v", "--log-level", "DEBUG" },
        runner = "pytest",
        python = function()
          if vim.env.VIRTUAL_ENV then
            return vim.env.VIRTUAL_ENV .. "/bin/python"
          end
          return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
        end,
      }),
      -- NOTE: additional adapters here
    },
    icons = {
      running = "⟳",
      passed = "✓",
      failed = "✗",
      unknown = "?",
    },
    output = {
      enabled = true,
      open_on_run = true,
    },
    status = {
      enabled = true,
      virtual_text = true,
      signs = true,
    },
    summary = {
      enabled = true,
      expand_errors = true,
      follow = true,
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
  })

  local keymap = vim.keymap
  keymap.set("n", "<A-t>", "<CMD>Neotest summary toggle<CR>", { desc = "neotest: toggle summary" })
  keymap.set("n", "<leader>tr", "<CMD>Neotest run<CR>", { desc = "neotest: test nearest" })
  keymap.set("n", "<leader>ts", "<CMD>Neotest stop<CR>", { desc = "neotest: test stop" })
  keymap.set("n", "<leader>tf", function()
    neotest.run.run(vim.fn.expand("%"))
  end, { desc = "neotest: test file" })
  keymap.set("n", "<leader>td", function()
    neotest.run.run({ strategy = "dap" })
  end, { desc = "neotest: test debug" })
  keymap.set("n", "<leader>tw", function()
    neotest.watch.toggle()
  end, { desc = "neotest: watch tests" })
  keymap.set("n", "<leader>twf", function()
    neotest.watch.toggle(vim.fn.expand("%"))
  end, { desc = "neotest: watch file tests" })

  keymap.set("n", "<leader>to", function()
    neotest.output.open({ enter = true })
  end, { desc = "neotest: open output" })
  keymap.set("n", "<leader>tO", function()
    neotest.output_panel.toggle()
  end, { desc = "neotest: toggle output panel" })
  keymap.set("n", "<leader>tl", function()
    neotest.run.run_last()
  end, { desc = "neotest: run last test" })
  keymap.set("n", "<leader>tj", function()
    neotest.jump.next({ status = "failed" })
  end, { desc = "neotest: jump to next failed test" })
  keymap.set("n", "<leader>tk", function()
    neotest.jump.prev({ status = "failed" })
  end, { desc = "neotest: jump to prev failed test" })
end

-- initialize debugging setup
function DAPConfig.setup()
  -- virtual text setup
  setup_virtual_text()

  -- integration with telescope
  DAPConfig.setup_telescope()

  -- mappings and ui
  DAPConfig.setup_mappings()

  -- language configs
  DAPConfig.setup_languages()

  -- neotest
  DAPConfig.setup_neotest()

  -- custom signs for breakpoints
  vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
  vim.fn.sign_define(
    "DapBreakpointCondition",
    { text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
  )
  vim.fn.sign_define("DapLogPoint", { text = "◉", texthl = "DapLogPoint", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })
  vim.fn.sign_define(
    "DapBreakpointRejected",
    { text = "○", texthl = "DapBreakpointRejected", linehl = "", numhl = "" }
  )
end

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-jdtls",
      "nvim-telescope/telescope-dap.nvim",
      "jayp0521/mason-nvim-dap.nvim",
      "mfussenegger/nvim-dap-python",
      {
        {
          "nvim-neotest/neotest",
          dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-neotest/neotest-python",
            "mfussenegger/nvim-dap",
          },
        },
      },
    },
    config = function()
      DAPConfig.setup()
    end,
  },
}
