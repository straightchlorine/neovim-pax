--- packer.lua
-- All plugins for packer to install along
-- with their configurations.
---

local config = require('configuration')

return require('packer').startup(function (use)
  use { 'wbthomason/packer.nvim'}

  use { 'nvim-lua/plenary.nvim' }

  use {'kevinhwang91/nvim-bqf',
    ft = 'qf',
    config = config.bqf
  }

  use {'junegunn/fzf',
    run = function()
      vim.fn['fzf#install']()
    end
  }

  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = config.treesitter
  }

  -- autocompletion plugins
  use { 'neovim/nvim-lspconfig' }
  use { 'hrsh7th/cmp-nvim-lsp' }

  use { 'neovim/nvim-lspconfig',
    requires = { 'hrsh7th/cmp-nvim-lsp' },
    config = config.lsp
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

  use { 'akinsho/bufferline.nvim',
    tag = "*",
    config = config.bufferline
  }

  use { 'skywind3000/asyncrun.vim' }

  use { 'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    config = config.telescope
  }

  use { 'lukas-reineke/indent-blankline.nvim',
    config = config.blankline
  }

  use { 'tpope/vim-commentary' }

  use { 'tpope/vim-obsession' }

  use { 'tpope/vim-eunuch' }

  use { 'Raimondi/delimitMate' }

  use { 'simnalamburt/vim-mundo' }

  use { 'godlygeek/tabular' }

  use { 'chrisbra/unicode.vim' }

  use { 'wellle/targets.vim' }

  use { 'machakann/vim-sandwich' }

  use { 'michaeljsmith/vim-indent-object' }

  use { 'andymass/vim-matchup' }

end)
