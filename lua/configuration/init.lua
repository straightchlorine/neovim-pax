--- init.lua
-- Initialization of the configuration module
-- containing configs for all the plugins.
---

local configuration = {}
  configuration.treesitter = function ()
    require('configuration.treesitter')
  end

  configuration.lsp = function ()
    require('configuration.lsp')
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

return configuration
