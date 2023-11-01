--- notify.lua
-- Configuration for nvim-notify plugin.
---

local notification = require('notify')

notification.setup {
  background_colour = 'NotifyBackground',
  fps = 165,
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
  stages = 'slide',
  timeout = 5000,
  top_down = false
}

vim.notify = notification

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
