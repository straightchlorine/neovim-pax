-- Modern LSP configuration using Neovim 0.11+ native APIs
-- Hybrid approach: native config where possible, lspconfig for complex setups

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local lspconfig = require("lspconfig")

    local keymap = vim.keymap
    -- Modern diagnostic configuration (Neovim 0.11+)
    vim.diagnostic.config({
      jump = { float = true },
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

        opts.desc = "lsp: show references"
        keymap.set("n", "gR", "<cmd>:Telescope lsp_references<CR>", opts)

        opts.desc = "lsp: go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "lsp: show definitions"
        keymap.set("n", "gd", "<cmd>:Telescope lsp_definitions<CR>", opts)

        opts.desc = "lsp: show implementations"
        keymap.set("n", "gi", "<cmd>:Telescope lsp_implementations<CR>", opts)

        opts.desc = "lsp: show type definitions"
        keymap.set("n", "gt", "<cmd>:Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "lsp: code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "lsp: rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "lsp: buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>:Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "lsp: inline diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "lsp: show doc on hover"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "lsp: restart lsp"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
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


    lspconfig["vale_ls"].setup({
      filetypes = { "markdown" },
    })

    lspconfig["lua_ls"].setup({
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
    })

    lspconfig["clangd"].setup({
      capabilities = capabilities,
      cmd = { "clangd", "--background-index" },
      filetypes = { "c", "cpp", "objc", "objcpp" },
      root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
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
    })

    -- Python LSP with comprehensive virtual environment support
    local function get_python_path(workspace)
      local util = require("lspconfig/util")
      local path = util.path
      
      -- 1. Check for VIRTUAL_ENV environment variable (most common)
      if vim.env.VIRTUAL_ENV then
        local venv_python = path.join(vim.env.VIRTUAL_ENV, "bin", "python3")
        if vim.fn.executable(venv_python) == 1 then
          return venv_python
        end
      end
      
      -- 2. Check for pyenv (your current setup)
      if vim.fn.executable("pyenv") == 1 then
        local pyenv_python = vim.fn.system("pyenv which python3 2>/dev/null"):gsub("\n", "")
        if vim.v.shell_error == 0 and pyenv_python ~= "" and vim.fn.executable(pyenv_python) == 1 then
          return pyenv_python
        end
      end
      
      -- 3. Check for conda environment
      if vim.env.CONDA_PREFIX then
        local conda_python = path.join(vim.env.CONDA_PREFIX, "bin", "python3")
        if vim.fn.executable(conda_python) == 1 then
          return conda_python
        end
      end
      
      -- 4. Check for pipenv in current project
      if vim.fn.executable("pipenv") == 1 and path.exists(path.join(workspace, "Pipfile")) then
        local pipenv_python = vim.fn.system("cd '" .. workspace .. "' && pipenv --py 2>/dev/null"):gsub("\n", "")
        if vim.v.shell_error == 0 and pipenv_python ~= "" and vim.fn.executable(pipenv_python) == 1 then
          return pipenv_python
        end
      end
      
      -- 5. Check for poetry in current project
      if vim.fn.executable("poetry") == 1 and path.exists(path.join(workspace, "pyproject.toml")) then
        local poetry_env = vim.fn.system("cd '" .. workspace .. "' && poetry env info -p 2>/dev/null"):gsub("\n", "")
        if vim.v.shell_error == 0 and poetry_env ~= "" then
          local poetry_python = path.join(poetry_env, "bin", "python3")
          if vim.fn.executable(poetry_python) == 1 then
            return poetry_python
          end
        end
      end
      
      -- 6. Check for local .venv directory
      local local_venv = path.join(workspace, ".venv", "bin", "python3")
      if vim.fn.executable(local_venv) == 1 then
        return local_venv
      end
      
      -- 7. Fallback to system python
      return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
    end

    -- Configure Pyright as the primary Python LSP
    lspconfig["pyright"].setup({
      capabilities = capabilities,
      before_init = function(_, config)
        local workspace = config.root_dir or vim.fn.getcwd()
        local python_path = get_python_path(workspace)
        config.settings.python.pythonPath = python_path
        
        -- Debug output (uncomment to debug Python path detection)
        -- vim.notify("Pyright using Python: " .. python_path, vim.log.levels.INFO)
      end,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            autoImportCompletions = true,
            diagnosticMode = "workspace",  -- Check entire workspace, not just open files
          },
          diagnostics = {
            -- More lenient diagnostics
            reportMissingImports = true,
            reportMissingTypeStubs = false,
            reportImportCycles = false,
            reportUnusedImport = "information",
            reportUnusedVariable = "information",
          },
        },
      },
    })

    -- Configure Ruff LSP with proper capabilities
    lspconfig["ruff"].setup({
      capabilities = capabilities,
    })

    -- Simple servers using native Neovim 0.11 APIs where possible
    local simple_servers = {
      "ts_ls",
      "texlab",
    }

    for _, server in ipairs(simple_servers) do
      lspconfig[server].setup({
        capabilities = capabilities,
      })
    end
  end,
}
