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

  configuration.cmp = function ()
    require('configuration.cmp')
  end

  configuration.cmp_ultisnips = function ()
    require('configuration.cmp-ultisnips')
  end

  configuration.ultisnips = function ()
    require('configuration.ultisnips')
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

  configuration.bqf = function ()
    require('configuration.bqf')
  end

  configuration.telescope = function ()
    require('configuration.telescope')
  end

  configuration.ibl = function ()
    require('configuration.ibl')
  end

  configuration.hop = function ()
    require('configuration.hop')
  end

  configuration.fugitive = function ()
    require('configuration.fugitive')
  end

  configuration.gitsigns = function ()
    require('configuration.gitsigns')
  end

  configuration.key = function ()
    require('configuration.key')
  end

  configuration.comment = function ()
    require('configuration.comment')
  end

  configuration.alpha = function ()
    require('configuration.alpha')
  end

  configuration.illuminate = function ()
    require('configuration.illuminate')
  end

  configuration.hlslens = function ()
    require('configuration.hlslens')
  end

  configuration.colorizer = function ()
    require('configuration.colorizer')
  end

  configuration.shade = function ()
    require('configuration.shade')
  end

  configuration.range_highlight = function ()
    require('configuration.range_highlight')
  end

  configuration.ccc = function ()
    require('configuration.ccc')
  end

  configuration.gpt = function ()
    require('configuration.gpt')
  end

  configuration.copilot = function ()
    require('configuration.copilot')
  end

  configuration.flutter_tools = function ()
    require('configuration.flutter-tools')
  end

return configuration
