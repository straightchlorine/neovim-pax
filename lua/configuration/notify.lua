--- notify.lua
-- Configuration for nvim-notify plugin
---

local notification = require('notify')

notification.setup {
  background_colour = 'NotifyBackground',
  fps = 60,
  icons = {
    DEBUG = '',
    ERROR = '',
    INFO = '',
    TRACE = '✎',
    WARN = ''
  },
  level = 2,
  minimum_width = 50,
  render = 'default',
  stages = 'fade_in_slide_out',
  timeout = 5000,
  top_down = true
}

vim.notify = notification
