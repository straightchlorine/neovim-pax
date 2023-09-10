--- init.lua
-- Initialization of the configuration module
-- containing configs for all the plugins.
---

local configuration = {}

  configuration.treesitter = function ()
    require('configuration.treesitter')
  end

  configuration.lspconfig = function ()
    require('configuration.lspconfig')
  end

  configuration.cmp = function ()
    require('configuration.cmp')
  end

  configuration.cmp_ultisnips = function ()
    require('configuration.cmp_ultisnips')
  end

  configuration.notify = function ()
    require('configuration.notify')
  end

  configuration.tree = function ()
    require('configuration.tree')
  end

  configuration.lualine = function ()
    require('configuration.lualine')
  end

  configuration.bufferline = function ()
    require('configuration.bufferline')
  end

return configuration
