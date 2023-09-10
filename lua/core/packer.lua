--- packer.lua
-- All plugins for packer to install along
-- with their configurations.
---

local config = require('configuration')

return require('packer').startup(function (use)
  use { 'wbthomason/packer.nvim'}

  use { 'nvim-lua/plenary.nvim' }

  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = config.treesitter
  }

  -- autocompletion plugins
  use { 'neovim/nvim-lspconfig',
    requires = { 'hrsh7th/cmp-nvim-lsp' },
    config = config.lspconfig
  }

  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'petertriho/cmp-git' }

  use { 'hrsh7th/nvim-cmp',
    config = config.cmp
  }

  use { 'SirVer/ultiships' }

  use { 'quangnguyen30192/cmp-nvim-ultisnips',
    config = config.cmp_ultisnips
  }

  use { 'rcarriga/nvim-notify',
    config = config.notify
  }

  use { 'nvim-tree/nvim-tree.lua',
    requires = 'nvim-tree/nvim-web-devicons',
    config = config.tree,
  }

  use { 'nvim-lualine/lualine.nvim',
    config = config.lualine
  }

end)
