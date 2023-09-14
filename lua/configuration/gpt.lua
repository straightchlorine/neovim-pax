--- gpt.lua
-- Configuration for ChatGPT.nvim plugin
---

require("chatgpt").setup {
  api_key_cmd = os.getenv('OPENAI_API_KEY')
}
