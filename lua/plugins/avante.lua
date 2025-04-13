-- avante.nvim
-- https://github.com/yetone/avante.nvim

return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  opts = {
    provider = "openai",
    openai = {
      endpoint = "https://api.openai.com/v1",
      model = "gpt-4o",
      timeout = 30000,
      temperature = 0,
      max_tokens = 8192,
    },
    provider = "copilot",
    copilot = {
      model = "claude-3.7-sonnet",
      behaviour = {
        auto_apply_diff_after_generation = false,
        enable_claude_text_editor_tool_mode = true,
      },
    },
    provider = "ollama",
    ollama = {
      model = "qwen2.5-coder:7b",
      endpoint = os.getenv("OLLAMA_ENDPOINT"),
    },
  },
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "ibhagwan/fzf-lua",
    "nvim-tree/nvim-web-devicons",
    "zbirenbaum/copilot.lua",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
