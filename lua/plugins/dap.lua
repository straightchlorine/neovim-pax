-- nvim-dap
-- https://github.com/mfussenegger/nvim-dap

local DAPConfig = {}

--- Setup virtual text display for variables during debugging
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

--- Setup DAP UI picker keymaps for browsing debug state
function DAPConfig.setup_dap_pickers()
  local dap = require("dap")
  local keymap = vim.keymap

  -- Using DAP's built-in commands since we removed telescope-dap
  keymap.set("n", "<leader>dl", function()
    require("dapui").float_element("breakpoints", { enter = true })
  end, { desc = "debug: list breakpoints" })

  keymap.set("n", "<leader>dv", function()
    require("dapui").float_element("scopes", { enter = true })
  end, { desc = "debug: list variables" })

  keymap.set("n", "<leader>df", function()
    require("dapui").float_element("stacks", { enter = true })
  end, { desc = "debug: list frames" })
end

--- Setup DAP UI configuration and layouts
---@return table dapui DAP UI instance
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
      border = "rounded",
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

--- Setup all DAP keymaps for debugging operations
function DAPConfig.setup_mappings()
  local dap = require("dap")
  local keymap = vim.keymap
  local dapui = setup_dap_ui()

  keymap.set("n", "<F5>", dap.continue, { desc = "debug: continue" })
  keymap.set("n", "<F10>", dap.step_over, { desc = "debug: step over" })
  keymap.set("n", "<F11>", dap.step_into, { desc = "debug: step into" })
  keymap.set("n", "<F12>", dap.step_out, { desc = "debug: step out" })

  keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "debug: toggle breakpoint" })
  keymap.set("n", "<Leader>B", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
  end, { desc = "debug: conditional breakpoint" })
  keymap.set("n", "<Leader>lp", function()
    dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
  end, { desc = "debug: breakpoint with log" })
  keymap.set("n", "<Leader>cb", dap.clear_breakpoints, { desc = "debug: clear all breakpoints" })

  keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "debug: open REPL" })
  keymap.set("n", "<Leader>rr", dap.run_last, { desc = "debug: run last" })
  keymap.set({ "n", "v" }, "<Leader>dp", function()
    require("dap.ui.widgets").preview()
  end, { desc = "debug: preview" })
  keymap.set({ "n", "v" }, "<Leader>dt", dap.terminate, { desc = "debug: terminate session" })
  keymap.set("n", "<Leader>dR", function()
    dap.restart()
  end, { desc = "debug: restart session" })

  keymap.set("n", "<Leader>dk", dapui.eval, { desc = "debug: evaluate expression" })
  keymap.set("n", "<Leader>du", function()
    dapui.toggle()
  end, { desc = "debug: toggle UI" })
  keymap.set("v", "<Leader>de", dapui.eval, { desc = "debug: evaluate selection" })
  keymap.set("n", "<Leader>dh", function()
    require("dap.ui.widgets").hover()
  end, { desc = "debug: hover variables" })

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

--- Configure DAP adapters for different programming languages
function DAPConfig.setup_languages()
  local dap = require("dap")

  --- Setup Python debugger using Mason's debugpy
  local function setup_python()
    local debugpy = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python'
    require("dap-python").setup(debugpy)

    -- Ensure the debugged program runs in the project's venv
    local function resolve_python()
      if _G.get_python_path then
        return _G.get_python_path(vim.fn.getcwd())
      elseif vim.env.VIRTUAL_ENV then
        return vim.env.VIRTUAL_ENV .. "/bin/python3"
      end
      return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
    end

    for _, config in ipairs(require("dap").configurations.python) do
      config.pythonPath = resolve_python
    end
  end

  --- Setup Java test debugging with JDTLS
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

  pcall(setup_python)
  pcall(setup_java)

  dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-dap",
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

  -- Reuse for C and Rust
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp

  dap.adapters.coreclr = {
    type = "executable",
    command = "netcoredbg",
    args = { "--interpreter=vscode" },
  }

  dap.configurations.cs = {
    {
      type = "coreclr",
      name = "Launch",
      request = "launch",
      program = function()
        return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
      end,
      cwd = "${workspaceFolder}",
    },
  }

  dap.adapters.delve = {
    type = 'server',
    port = '${port}',
    executable = {
      command = 'dlv',
      args = { 'dap', '-l', '127.0.0.1:${port}' },
    }
  }

  dap.configurations.go = {
    {
      type = "delve",
      name = "Debug",
      request = "launch",
      program = "${file}"
    },
    {
      type = "delve",
      name = "Debug test",
      request = "launch",
      mode = "test",
      program = "${file}"
    },
    {
      type = "delve",
      name = "Debug test (go.mod)",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}"
    }
  }
end


function DAPConfig.setup()
  setup_virtual_text()
  DAPConfig.setup_dap_pickers()
  DAPConfig.setup_mappings()
  DAPConfig.setup_languages()

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
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-jdtls",
    "jayp0521/mason-nvim-dap.nvim",
    "mfussenegger/nvim-dap-python",
  },
  config = function()
    DAPConfig.setup()
  end,
}
