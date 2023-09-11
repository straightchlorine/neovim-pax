--- init.lua
-- Initialization of the configuration module
-- containing configs for all the plugins.
---

local configuration = {}
  configuration.treesitter = function ()
    require('configuration.treesitter')
  end

<<<<<<< Updated upstream
  configuration.lsp = function ()
    require('configuration.lsp')
=======
  configuration.lspconfig = function ()
    require('configuration.lsp')
  end

  configuration.cmp = function ()
    require('configuration.cmp')
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
=======
  configuration.lualine = function ()
    require('configuration.lualine')
  end

  configuration.bufferline = function ()
    require('configuration.bufferline')
  end

  configuration.bqf = function ()
    require('configuration.bqf')
  end

  configuration.telescope = function ()
    require('configuration.telescope')
  end

  configuration.blankline = function ()
    require('configuration.blankline')
  end

>>>>>>> Stashed changes
return configuration
