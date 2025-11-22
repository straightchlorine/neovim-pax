-- Modern LSP configuration using Neovim 0.11+ native APIs
-- Migrated to vim.lsp.config to avoid deprecation warnings

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()

    local keymap = vim.keymap

    -- Configure LSP floating window borders
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = "rounded" }
    )
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { border = "rounded" }
    )

    -- Modern diagnostic configuration (Neovim 0.11+)
    vim.diagnostic.config({
      jump = { float = true },
      float = { border = "rounded" },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        -- Disable LSP formatting in favor of conform.nvim
        if client.supports_method("textDocument/formatting") then
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end

        -- LSP navigation handled by snacks.nvim pickers (gd, gD, gR, gI, gy)
        -- This provides better UI and consistency with other pickers

        opts.desc = "lsp: code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "lsp: rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "lsp: buffer diagnostics"
        keymap.set("n", "<leader>DD", function() require("snacks").picker.diagnostics_buffer() end, opts)

        opts.desc = "lsp: inline diagnostics"
        keymap.set("n", "<leader>Di", vim.diagnostic.open_float, opts)

        opts.desc = "lsp: show doc on hover"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "lsp: restart lsp"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

        opts.desc = "lsp: toggle inlay hints"
        keymap.set("n", "<leader>lh", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }))
        end, opts)

        if client and client.supports_method("textDocument/inlayHint") then
          vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
        end
      end,
    })

    local capabilities = require('blink.cmp').get_lsp_capabilities()

    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    -- Fix position encoding conflicts - use UTF-16 consistently
    capabilities.general = capabilities.general or {}
    capabilities.general.positionEncodings = { "utf-16" }

    local servers = {
      vale_ls = {
        filetypes = { "markdown" },
      },
      lua_ls = {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "awesome" },
            },
            completion = {
              callSnippet = "Replace",
            },
            hint = {
              enable = true,
            },
          },
        },
      },
      clangd = {
        capabilities = capabilities,
        cmd = { "clangd", "--background-index" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
        settings = {
          ccls = {
            completion = {
              filterAndSort = false,
            },
            index = {
              blacklist = { "build" },
              threads = 0,
            },
            workspace = {
              compilationDatabaseDirectory = "build",
              directory = ".",
            },
          },
        },
      },
      gopls = {
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      },
    }

    -- Python LSP with comprehensive virtual environment support
    -- This function is used by LSP, DAP, and neotest for consistent venv detection
    local function get_python_path(workspace)
      -- Helper function to join paths
      local function joinpath(...)
        return table.concat({...}, "/")
      end

      -- Helper function to check if file exists
      local function file_exists(path)
        return vim.uv.fs_stat(path) ~= nil
      end

      -- Priority order for virtual environment detection:
      -- 1. VIRTUAL_ENV (explicit environment variable)
      -- 2. UV (.venv with uv.lock indicator)
      -- 3. pyenv
      -- 4. conda
      -- 5. pipenv
      -- 6. poetry
      -- 7. Generic .venv
      -- 8. System Python

      -- 1. Check for VIRTUAL_ENV environment variable (highest priority)
      if vim.env.VIRTUAL_ENV then
        local venv_python = joinpath(vim.env.VIRTUAL_ENV, "bin", "python3")
        if vim.fn.executable(venv_python) == 1 then
          return venv_python
        end
      end

      -- 2. Check for UV project (.venv with uv.lock or pyproject.toml managed by uv)
      local uv_venv = joinpath(workspace, ".venv", "bin", "python3")
      if vim.fn.executable(uv_venv) == 1 then
        -- Check if this is a uv-managed project
        if file_exists(joinpath(workspace, "uv.lock")) or
           file_exists(joinpath(workspace, ".python-version")) then
          return uv_venv
        end
      end

      -- 3. Check for pyenv
      if vim.fn.executable("pyenv") == 1 then
        local pyenv_python = vim.fn.system("pyenv which python3 2>/dev/null"):gsub("\n", "")
        if vim.v.shell_error == 0 and pyenv_python ~= "" and vim.fn.executable(pyenv_python) == 1 then
          return pyenv_python
        end
      end

      -- 4. Check for conda environment
      if vim.env.CONDA_PREFIX then
        local conda_python = joinpath(vim.env.CONDA_PREFIX, "bin", "python3")
        if vim.fn.executable(conda_python) == 1 then
          return conda_python
        end
      end

      -- 5. Check for pipenv in current project
      if vim.fn.executable("pipenv") == 1 and file_exists(joinpath(workspace, "Pipfile")) then
        local pipenv_python = vim.fn.system("cd '" .. workspace .. "' && pipenv --py 2>/dev/null"):gsub("\n", "")
        if vim.v.shell_error == 0 and pipenv_python ~= "" and vim.fn.executable(pipenv_python) == 1 then
          return pipenv_python
        end
      end

      -- 6. Check for poetry in current project
      if vim.fn.executable("poetry") == 1 and file_exists(joinpath(workspace, "pyproject.toml")) then
        local poetry_env = vim.fn.system("cd '" .. workspace .. "' && poetry env info -p 2>/dev/null"):gsub("\n", "")
        if vim.v.shell_error == 0 and poetry_env ~= "" then
          local poetry_python = joinpath(poetry_env, "bin", "python3")
          if vim.fn.executable(poetry_python) == 1 then
            return poetry_python
          end
        end
      end

      -- 7. Check for generic local .venv directory (fallback for any venv)
      if vim.fn.executable(uv_venv) == 1 then
        return uv_venv
      end

      -- 8. Fallback to system python
      return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
    end

    -- Make get_python_path globally accessible for DAP and neotest
    _G.get_python_path = get_python_path

    servers.pyright = {
      capabilities = capabilities,
      before_init = function(_, config)
        local workspace = config.root_dir or vim.fn.getcwd()
        local python_path = get_python_path(workspace)
        config.settings.python.pythonPath = python_path
      end,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            autoImportCompletions = true,
            diagnosticMode = "workspace",
          },
          diagnostics = {
            reportMissingImports = true,
            reportMissingTypeStubs = false,
            reportImportCycles = false,
            reportUnusedImport = "information",
            reportUnusedVariable = "information",
          },
        },
      },
    }

    servers.ruff = {
      capabilities = capabilities,
    }

    servers.emmet_ls = {
      capabilities = capabilities,
      filetypes = {
        "html",
        "css",
        "scss",
        "sass",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "vue",
        "svelte",
      },
      init_options = {
        html = {
          options = {
            ["bem.enabled"] = true,
          },
        },
      },
    }

    local simple_servers = {
      "texlab",
      "tailwindcss",
      "cssls",
      "html",
      "jsonls",
      "eslint",
    }

    for _, server in ipairs(simple_servers) do
      servers[server] = { capabilities = capabilities }
    end

    for server, config in pairs(servers) do
      vim.lsp.config(server, config)
      vim.lsp.enable(server)
    end
  end,
}
