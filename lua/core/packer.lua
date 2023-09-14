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

  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'neovim/nvim-lspconfig',
    config = config.lsp
  }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'petertriho/cmp-git' }
  use { 'lukas-reineke/cmp-under-comparator' }
  use { 'hrsh7th/nvim-cmp',
    config = config.cmp
  }

  use { 'SirVer/ultiships' }

  use { 'quangnguyen30192/cmp-nvim-ultisnips',
    config = config.cmp_ultisnips
  }

  use { 'folke/which-key.nvim',
    config = config.key
  }

  use { 'sakhnik/nvim-gdb' }

  use { 'mfussenegger/nvim-dap' }

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
    tag = '*',
    config = config.bufferline
  }

  use { 'skywind3000/asyncrun.vim' }

  use { 'kevinhwang91/promise-async' }

  use { 'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    config = config.telescope
  }

  use { 'nvim-lua/popup.nvim' }

  use { 'sudormrfbin/cheatsheet.nvim' }

  use { 'kevinhwang91/nvim-ufo' }

  use { 'lukas-reineke/indent-blankline.nvim',
    config = config.blankline
  }

  use {
    'numToStr/Comment.nvim',
    config = config.comment
  }

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

  use { 'ojroques/vim-oscyank',
    branch = 'main'
  }

  use { 'phaazon/hop.nvim',
    branch = 'v2',
    config = config.hop
  }

  use { 'tpope/vim-fugitive',
    config = config.fugitive
  }

  use { 'rbong/vim-flog',
    cmd = { 'Flog' }
  }

  use { 'lewis6991/gitsigns.nvim',
    config = config.gitsigns
  }
  
  use { 'andymass/diffview.nvim' }
 
  use { 'lervag/vimtex' }

  use { 'goolord/alpha-nvim',
    config = config.alpha
  }

  use { 'rrethy/vim-illuminate',
    config = config.illuminate
  }

  use { 'kevinhwang91/nvim-hlslens',
    config = config.hlslens
  }

  use { 'norcalli/nvim-colorizer.lua',
    config = config.colorizer
  }

  use { 'sunjon/shade.nvim',
    config = config.shade
  }

  use { 'winston0410/cmd-parser.nvim' }

  use { 'winston0410/range-highlight.nvim',
    config = config.range_highlight
  }

  use { 'folke/twilight.nvim' }

  use { 'uga-rosa/ccc.nvim',
    config = config.ccc
  }

  use { 'MunifTanjim/nui.nvim' }

  use { 'jackMort/ChatGPT.nvim',
    config = config.gpt
  }

end)
