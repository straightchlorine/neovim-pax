-- typescript-tools.nvim
-- https://github.com/pmizio/typescript-tools.nvim

return {
  "pmizio/typescript-tools.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
  },
  ft = {
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
  },
  opts = {
    on_attach = function(client, bufnr)
      -- Disable formatting (let conform.nvim handle it)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
    settings = {
      -- Spawn additional tsserver instance for faster diagnostics
      separate_diagnostic_server = true,
      -- "change" | "insert_leave" - when to publish diagnostics
      publish_diagnostic_on = "insert_leave",
      -- Array of strings that should trigger organize imports code action
      expose_as_code_action = "all",
      -- String | nil - specify the path to the tsserver.js file
      tsserver_path = nil,
      -- Specify max file size for TypeScript server to handle (in KB)
      tsserver_max_memory = "auto",
      -- Locale to use for TypeScript messages
      tsserver_locale = "en",
      -- Mirror tsserver's log to output
      tsserver_logs = "off",
      -- TypeScript preferences
      tsserver_file_preferences = {
        -- Inlay hints
        includeInlayParameterNameHints = "all", -- "none" | "literals" | "all"
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
        -- Import preferences
        includeCompletionsForModuleExports = true,
        includeCompletionsForImportStatements = true,
        includeCompletionsWithSnippetText = true,
        includeAutomaticOptionalChainCompletions = true,
        includeCompletionsWithInsertText = true,
        -- Suggestions
        autoImportFileExcludePatterns = {},
        organizeImportsIgnoreCase = "auto",
        organizeImportsCollation = "ordinal",
        -- Display preferences
        quotePreference = "auto", -- "auto" | "double" | "single"
      },
      -- Format settings
      tsserver_format_options = {
        allowIncompleteCompletions = false,
        allowRenameOfImportPath = false,
      },
      -- Plugin integration
      tsserver_plugins = {},
      -- Experimental features
      complete_function_calls = false,
      include_completions_with_insert_text = true,
      -- Code lens
      code_lens = "off", -- "off" | "implementations_only" | "references_only" | "all"
      -- Disable some features for better performance
      disable_member_code_lens = true,
    },
  },
}

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
