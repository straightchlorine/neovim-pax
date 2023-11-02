--- gpt.lua
-- Configuration for ChatGPT.nvim plugin.
---

require('chatgpt').setup {
  api_key_cmd = os.getenv('OPENAI_API_KEY')
}

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
