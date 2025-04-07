-- gp.nvim
-- https://github.com/Robitx/gp.nvim

return {
  "robitx/gp.nvim",
  config = function()
    local conf = {

      providers = {
        openai = {
          endpoint = "https://api.openai.com/v1/chat/completions",
          secret = os.getenv("OPENAI_API_KEY"),
        },

        copilot = {
          endpoint = "https://api.githubcopilot.com/chat/completions",
          secret = {
            "bash",
            "-c",
            "cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
          },
        },

        pplx = {
          endpoint = "https://api.perplexity.ai/chat/completions",
          secret = os.getenv("PPLX_API_KEY"),
        },

        ollama = {
          endpoint = "http://server:11434/v1/chat/completions",
        },

        googleai = {
          endpoint = "https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}",
          secret = os.getenv("GOOGLEAI_API_KEY"),
        },

        anthropic = {
          endpoint = "https://api.anthropic.com/v1/messages",
          secret = os.getenv("ANTHROPIC_API_KEY"),
        },
      },
    }
    require("gp").setup(conf)
  end,
}
