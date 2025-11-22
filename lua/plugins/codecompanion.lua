-- codecompanion.nvim
-- https://github.com/olimorris/codecompanion.nvim

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "saghen/blink.cmp", -- Optional: For using slash commands and variables in the chat buffer
    "folke/snacks.nvim", -- Optional: Improves `vim.ui.select` (replaces archived dressing.nvim)
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "anthropic",
        },
        inline = {
          adapter = "anthropic",
        },
        agent = {
          adapter = "anthropic",
          tools = {
            ["editor"] = {
              enabled = true,
            },
            ["cmd_runner"] = {
              enabled = true,
            },
            ["rag"] = {
              enabled = true,
            },
          },
        },
      },
      adapters = {
        http = {
          -- Claude Code Integration (Uses your Pro plan via bearer token)
          -- Extract token from Claude Code DevTools (Ctrl+Shift+I → Network tab)
          -- Then set: export ANTHROPIC_BEARER_TOKEN=your_token_here
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = { bearer_token = "ANTHROPIC_BEARER_TOKEN" },
              headers = {
                ["authorization"] = "Bearer ${bearer_token}",
                ["anthropic-beta"] = "claude-code-20250219,oauth-2025-04-20",
              },
              handlers = {
                setup = function(self)
                  self.headers["x-api-key"] = nil
                  return true
                end,
              },
              schema = {
                model = {
                  default = "claude-sonnet-4-20250514",
                },
              },
            })
          end,
        },
      },
      opts = {
        -- Set to false to disable default behavior of auto showing/hiding the chat buffer
        auto_chat = true,
        -- Set to true to send code context with inline requests
        send_code = true,
        -- Set to false to disable the use of the system prompt
        use_default_actions = true,
        -- Set to false to disable the default keymaps in the chat buffer
        use_default_prompt_library = true,
        -- Set the log level for more verbose output
        log_level = "ERROR", -- TRACE, DEBUG, INFO, WARN, ERROR
        -- Set to false to disable saving chat messages to disk
        save_chats = true,
        -- The directory to save chat messages to
        saved_chats_dir = vim.fn.stdpath("data") .. "/codecompanion/saved_chats",
        -- System prompt to use for the chat buffer
        system_prompt = "You are an AI programming assistant named CodeCompanion. You are currently plugged in to the Neovim text editor on a user's machine.\n\nYour core tasks include:\n- Answering general programming questions.\n- Explaining code that the user provides or you write.\n- Generating code based on the user's requirements.\n- Assisting users with their development workflow.\n\nYour responses should be:\n- Concise but helpful.\n- Accurate and well-reasoned.\n- Written in a clear and professional tone.\n- Formatted using Neovim-flavored Markdown where appropriate.\n\nYou have access to the user's currently opened file. If you need to reference or modify it, you can assume it's the primary context unless the user specifies otherwise.\n\nIf you're unsure about something, it's okay to admit that and ask for clarification rather than guessing.",
      },
      -- DISPLAY OPTIONS --
      display = {
        action_palette = {
          width = 95,
          height = 10,
        },
        chat = {
          -- The default header text to display at the top of the chat buffer
          welcome_message = "Welcome to CodeCompanion ✨",
          -- Show the token count of the current conversation
          show_token_count = true,
          -- Border to use for the chat buffer. Options are single, double, rounded, solid, shadow
          border = "rounded",
          -- What to show in the header of the chat buffer:
          -- • name - just the name of the chat
          -- • model - the model being used in the chat
          -- • both - name and model
          show_header = "both",
        },
        inline = {
          -- If the inline prompt creates a new buffer, how should we display this?
          layout = "buffer", -- vertical, horizontal, buffer
        },
      },
      keymaps = {
        ["<C-s>"] = "keymaps.save", -- Save the chat buffer and trigger the API
        ["<C-c>"] = "keymaps.close", -- Close the chat buffer
        ["q"] = "keymaps.cancel_request", -- Cancel the streaming request
        ["gc"] = "keymaps.clear", -- Clear the contents of the chat
        ["ga"] = "keymaps.codeblock_to_action", -- Turn the code block into an action
        ["]"] = "keymaps.next", -- Move to the next chat
        ["["] = "keymaps.previous", -- Move to the previous chat
      },
    })

    -- Keybindings (changed from <C-a> to preserve Vim's increment command)
    vim.keymap.set("n", "<leader>ai", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true, desc = "codecompanion: action palette" })
    vim.keymap.set("v", "<leader>ai", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true, desc = "codecompanion: action palette" })
    vim.keymap.set("n", "<LocalLeader>a", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true, desc = "codecompanion: toggle chat" })
    vim.keymap.set("v", "<LocalLeader>a", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true, desc = "codecompanion: toggle chat" })
    vim.keymap.set("v", "ga", "<cmd>CodeCompanionAdd<cr>", { noremap = true, silent = true, desc = "codecompanion: add to chat" })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])
  end,
}