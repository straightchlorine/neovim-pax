-- avante.nvim
-- https://github.com/yetone/avante.nvim

return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  opts = {
    -- Default provider - can be overridden
    provider = "claude", -- Can be "claude", "openai", "azure", "gemini", "cohere", "copilot", "ollama"
    
    -- Auto suggestions configuration
    auto_suggestions = true, -- Experimental stage
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = false,
    
    -- Behaviour settings
    behaviour = {
      auto_suggestions = false, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
    },

    -- Mappings
    mappings = {
      --- @class AvanteConflictMappings
      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      sidebar = {
        switch_windows = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
      },
    },

    hints = { enabled = true },
    
    -- Windows configuration
    windows = {
      position = "right", -- the position of the sidebar
      wrap = true, -- similar to vim.o.wrap
      width = 30, -- default % based on available width
      sidebar_header = {
        align = "center", -- left, center, right for title
        rounded = true,
      },
      input = {
        prefix = "> ",
        height = 8, -- Height of the input window in horizontal layout
      },
      edit = {
        border = "rounded",
        start_insert = true, -- Start insert mode when opening the edit window
      },
      ask = {
        floating = false, -- Open the 'AvanteAsk' command in a floating window
        start_insert = true, -- Start insert mode when opening the ask window
        border = "rounded",
        --- @type "ours" | "theirs"
        focus_on_apply = "ours", -- which diff to focus after applying
      },
    },

    highlights = {
      --- @type AvanteConflictHighlights
      diff = {
        current = "DiffText",
        incoming = "DiffAdd",
      },
    },

    --- @class AvanteConflictUserConfig
    diff = {
      autojump = true,
      --- @type string | fun(): string
      list_opener = "copen",
      --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
      --- Helps to avoid entering operator-pending mode with diff keymap (e.g. dc or dp).
      --- Set to -1 to disable.
      override_timeoutlen = 500,
    },

    -- Provider configurations
    providers = {
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20241022",
        api_key_name = "ANTHROPIC_API_KEY",
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
      },
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o-mini",
        timeout = 30000,
        api_key_name = "OPENAI_API_KEY",
        ["local"] = false,
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
      },
      azure = {
        endpoint = "", -- example: "https://<your-resource-name>.openai.azure.com"
        deployment = "", -- Azure deployment name (e.g., "gpt-4o-mini")
        api_version = "2024-06-01",
        timeout = 30000,
        api_key_name = "AZURE_API_KEY",
        ["local"] = false,
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
      },
      gemini = {
        endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
        model = "gemini-1.5-flash-latest",
        timeout = 30000,
        api_key_name = "GEMINI_API_KEY",
        ["local"] = false,
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
      },
      cohere = {
        endpoint = "https://api.cohere.com/v1",
        model = "command-r-plus-08-2024",
        timeout = 30000,
        api_key_name = "COHERE_API_KEY",
        ["local"] = false,
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
      },
      copilot = {
        endpoint = "https://api.githubcopilot.com",
        model = "gpt-4o-2024-05-13",
        proxy = nil, -- [protocol://]host[:port] Use this proxy
        allow_insecure = false, -- Allow insecure server connections
        timeout = 30000,
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
      },
      ollama = {
        ["local"] = true,
        endpoint = "http://127.0.0.1:11434/v1",
        model = "qwen2.5-coder:7b",
        parse_curl_args = function(opts, code_opts)
        return {
          url = opts.endpoint .. "/chat/completions",
          headers = {
            ["Accept"] = "application/json",
            ["Content-Type"] = "application/json",
          },
          body = {
            model = opts.model,
            messages = require("avante.providers").copilot.parse_message(code_opts), -- you can make your own message parser
            max_tokens = 2048,
            stream = true,
          },
        }
        end,
        parse_response_data = function(data_stream, event_state, opts)
          require("avante.providers").openai.parse_response(data_stream, event_state, opts)
        end,
      },
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "folke/snacks.nvim", -- Replaces archived dressing.nvim for UI interfaces
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
