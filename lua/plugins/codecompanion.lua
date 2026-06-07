-- codecompanion.nvim
-- https://github.com/olimorris/codecompanion.nvim
-- docs: https://codecompanion.olimorris.dev

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "saghen/blink.cmp", -- slash commands + variables in chat buffer
    "folke/snacks.nvim", -- improves vim.ui.select
  },
  cmd = {
    "CodeCompanion",
    "CodeCompanionChat",
    "CodeCompanionActions",
    "CodeCompanionCmd",
    "CodeCompanionCLI",
  },
  keys = {
    { "<leader>ai", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "codecompanion: action palette" },
    { "<localleader>a", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "codecompanion: toggle chat" },
    { "ga", ":CodeCompanionChat Add<cr>", mode = "v", desc = "codecompanion: add selection to chat" },
    { "<localleader>c", "<cmd>CodeCompanionCLI<cr>", mode = "n", desc = "codecompanion: Claude Code CLI" },
    -- visual: plain `:` so `'<,'>` range is passed (a `<cmd>` mapping drops the range)
    {
      "<localleader>c",
      ":CodeCompanionCLI<cr>",
      mode = "v",
      desc = "codecompanion: send selection to Claude Code CLI",
    },
  },
  opts = {
    interactions = {
      chat = {
        adapter = "anthropic",
      },
      inline = {
        adapter = "anthropic",
      },
      cmd = {
        adapter = "anthropic",
      },
      cli = {
        agent = "claude_code",
        agents = {
          claude_code = {
            cmd = "claude",
            args = {},
            description = "Claude Code CLI",
            provider = "terminal",
          },
        },
      },
    },
    adapters = {
      http = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            schema = {
              model = {
                default = "claude-sonnet-4-6",
              },
            },
          })
        end,
      },
    },
    opts = {
      log_level = "ERROR",
      send_code = true,
    },
    display = {
      action_palette = {
        width = 95,
        height = 10,
      },
      chat = {
        intro_message = "Welcome",
        window = {
          layout = "vertical",
          border = "rounded",
        },
      },
      inline = {
        layout = "buffer",
      },
    },
  },
  config = function(_, opts)
    require("codecompanion").setup(opts)
    vim.cmd([[cab cc CodeCompanion]])
  end,
}
