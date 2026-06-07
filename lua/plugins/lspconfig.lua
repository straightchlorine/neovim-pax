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

    vim.o.winborder = "none"

    vim.diagnostic.config({
      jump = { float = true },
      float = { border = "none" },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        -- Formatting is handled by conform.nvim with lsp_format = "fallback":
        -- conform's own formatters run for configured filetypes, LSP formats the
        -- rest. We do NOT disable LSP formatting here -- that would kill the
        -- fallback (and conform never double-formats: it only calls LSP when it
        -- has no formatter for the filetype).

        opts.desc = "lsp: code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "lsp: rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "lsp: buffer diagnostics"
        keymap.set("n", "<leader>DD", function()
          require("snacks").picker.diagnostics_buffer()
        end, opts)

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

        if client and client:supports_method("textDocument/inlayHint") then
          vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
        end
      end,
    })

    local capabilities = require("blink.cmp").get_lsp_capabilities()

    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    capabilities.general = capabilities.general or {}
    capabilities.general.positionEncodings = { "utf-16" }

    -- Ensuring PlatformIO cross-compiler names binds are on PATH (for clangd).
    local pio_pkgs = vim.fn.expand("~/.platformio/packages")
    local clangd_env
    if vim.fn.isdirectory(pio_pkgs) == 1 then
      local bins = vim.fn.glob(pio_pkgs .. "/*/bin", true, true)
      if #bins > 0 then
        clangd_env = { PATH = table.concat(bins, ":") .. ":" .. (vim.env.PATH or "") }
      end
    end

    local servers = {
      vale_ls = {
        filetypes = { "markdown" },
      },
      lua_ls = {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "awesome", "Snacks" },
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
        cmd_env = clangd_env,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=never",
          "--completion-style=detailed",
          "--function-arg-placeholders=true",
          -- Allow clangd to query the cross-compilers so it pulls
          -- newlisb sysroot + target macros.
          "--query-driver=" .. pio_pkgs .. "/*/bin/*",
        },
        filetypes = { "c", "cpp", "objc", "objcpp", "arduino" },
        root_markers = { "compile_commands.json", "platformio.ini", "compile_flags.txt", "sketch.yaml", ".git" },
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

    -- For standalone arduino-cli sketches.
    if vim.fn.executable("arduino-cli") == 1 then
      servers.arduino_language_server = {
        capabilities = capabilities,
        cmd = {
          "arduino-language-server",
          "-cli-config",
          vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
          "-clangd",
          "clangd",
        },
        filetypes = { "arduino" },
        root_markers = { "sketch.yaml", ".git" },
      }
    end

    -- Python LSP with venv support.
    -- This function is used by LSP, DAP, and neotest.
    local function get_python_path(workspace)
      -- Helper to join paths
      local function joinpath(...)
        return table.concat({ ... }, "/")
      end

      -- Helper to check if file exists
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

      -- 1. Check for VIRTUAL_ENV var
      if vim.env.VIRTUAL_ENV then
        local venv_python = joinpath(vim.env.VIRTUAL_ENV, "bin", "python3")
        if vim.fn.executable(venv_python) == 1 then
          return venv_python
        end
      end

      -- 2. Check for UV project
      local uv_venv = joinpath(workspace, ".venv", "bin", "python3")
      if vim.fn.executable(uv_venv) == 1 then
        if file_exists(joinpath(workspace, "uv.lock")) or file_exists(joinpath(workspace, ".python-version")) then
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

      -- 4. Check for conda
      if vim.env.CONDA_PREFIX then
        local conda_python = joinpath(vim.env.CONDA_PREFIX, "bin", "python3")
        if vim.fn.executable(conda_python) == 1 then
          return conda_python
        end
      end

      -- 5. Check for pipenv
      if vim.fn.executable("pipenv") == 1 and file_exists(joinpath(workspace, "Pipfile")) then
        local pipenv_python = vim.fn.system("cd '" .. workspace .. "' && pipenv --py 2>/dev/null"):gsub("\n", "")
        if vim.v.shell_error == 0 and pipenv_python ~= "" and vim.fn.executable(pipenv_python) == 1 then
          return pipenv_python
        end
      end

      -- 6. Check for poetry
      if vim.fn.executable("poetry") == 1 and file_exists(joinpath(workspace, "pyproject.toml")) then
        local poetry_env = vim.fn.system("cd '" .. workspace .. "' && poetry env info -p 2>/dev/null"):gsub("\n", "")
        if vim.v.shell_error == 0 and poetry_env ~= "" then
          local poetry_python = joinpath(poetry_env, "bin", "python3")
          if vim.fn.executable(poetry_python) == 1 then
            return poetry_python
          end
        end
      end

      -- 7. Check for generic local .venv (fallback)
      if vim.fn.executable(uv_venv) == 1 then
        return uv_venv
      end

      -- 8. Fallback to system python
      return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
    end

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
            reportMissingImports = true,
            reportMissingTypeStubs = false,
            reportImportCycles = false,
            reportUnusedImport = "information",
            reportUnusedVariable = "information",
            reportAssignmentType = "warning",
            reportAttributeAccessIssue = "warning",
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

    -- Vue 3
    local vue_plugin = {
      name = "@vue/typescript-plugin",
      location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
      languages = { "vue" },
      configNamespace = "typescript",
    }

    local ts_inlay_hints = {
      parameterNames = { enabled = "all" },
      parameterTypes = { enabled = true },
      variableTypes = { enabled = true },
      propertyDeclarationTypes = { enabled = true },
      functionLikeReturnTypes = { enabled = true },
      enumMemberValues = { enabled = true },
    }

    servers.vtsls = {
      capabilities = capabilities,
      filetypes = {
        "typescript",
        "javascript",
        "typescriptreact",
        "javascriptreact",
        "vue",
      },
      settings = {
        vtsls = {
          tsserver = {
            globalPlugins = { vue_plugin },
          },
        },
        typescript = { inlayHints = ts_inlay_hints },
        javascript = { inlayHints = ts_inlay_hints },
      },
    }

    servers.vue_ls = {
      capabilities = capabilities,
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
