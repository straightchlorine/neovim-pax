-- nvim-lspconfig
-- https://github.com/neovim/nvim-lspconfig

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap
    vim.diagnostic.config({ jump = { float = true } })

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

    local capabilities = cmp_nvim_lsp.default_capabilities()

    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["vale_ls"] = function()
        lspconfig["vale_ls"].setup({
          filetypes = { "markdown" },
        })
      end,
      ["lua_ls"] = function()
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
      end,
      ["clangd"] = function()
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
      end,
    })
  end,
}
