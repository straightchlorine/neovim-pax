--- packer.lua
-- All plugins for packer to install along
-- with their configurations.
---

local config = require('configuration')

return require('packer').startup(function (use)

  use { 'wbthomason/packer.nvim'}

  use { 'skywind3000/asyncrun.vim' }

  use { 'kevinhwang91/promise-async' }

  use { 'nvim-lua/plenary.nvim' }

  use { 'MunifTanjim/nui.nvim' }

  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = config.treesitter
  }

  use {'kevinhwang91/nvim-bqf',
    ft = 'qf',
    config = config.bqf
  }

  use { 'folke/which-key.nvim',
    config = config.key
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

  use { 'rcarriga/nvim-notify',
    config = config.notify
  }

  use { 'nvim-lua/popup.nvim' }

  use { 'sudormrfbin/cheatsheet.nvim' }

  use { 'lukas-reineke/indent-blankline.nvim',
    config = config.ibl,
    main = 'ibl',
    opts = {}
  }

  use {
    'numToStr/Comment.nvim',
    config = config.comment
  }

  use { 'sakhnik/nvim-gdb' }

  use { 'mfussenegger/nvim-dap' }

  use {'junegunn/fzf',
    run = ':call fzf#install()'
  }
  use {'junegunn/fzf.vim',}

  use { 'nvim-telescope/telescope-dap.nvim' }

  use { 'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    config = config.telescope
  }

  use { 'onsails/lspkind.nvim' }

  use { 'SirVer/ultisnips',
    requires = {
      'honza/vim-snippets',
      rtp = '.'
    },
    config = config.ultisnips
  }

  use { 'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = config.copilot
  }

  use { 'jackMort/ChatGPT.nvim',
    config = config.gpt
  }

  use { 'hrsh7th/cmp-nvim-lsp' }

  use { 'neovim/nvim-lspconfig',
    config = config.lsp
  }

  use { 'hrsh7th/cmp-buffer' }

  use { 'hrsh7th/cmp-path' }

  use { 'hrsh7th/cmp-cmdline' }

  use { 'quangnguyen30192/cmp-nvim-ultisnips',
    config = config.cmp_ultisnips
  }

  use { 'hrsh7th/cmp-nvim-lsp-signature-help' }

  use { 'petertriho/cmp-git' }

  use { 'jalvesaq/cmp-nvim-r' }

  use { 'zbirenbaum/copilot-cmp',
    config = function ()
      require('copilot_cmp').setup()
    end
  }

  use { 'hrsh7th/nvim-cmp',
    config = config.cmp
  }

  use { 'lervag/vimtex' }

  use { 'mfussenegger/nvim-jdtls' }

  use { 'scalameta/nvim-metals' }

  use { 'jalvesaq/Nvim-R' }

  use { 'dart-lang/dart-vim-plugin' }

  use { 'akinsho/flutter-tools.nvim',
    config = config.flutter_tools
  }

  use { 'iamcco/markdown-preview.nvim',
    run = 'cd app && npm install',
    setup = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  }

  use { 'uga-rosa/ccc.nvim',
    config = config.ccc
  }


  use { 'lewis6991/gitsigns.nvim',
    config = config.gitsigns
  }

  use { 'sindrets/diffview.nvim' }

  use { 'kevinhwang91/nvim-ufo' }

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

  use { 'rrethy/vim-illuminate',
    config = config.illuminate
  }

  use { 'kevinhwang91/nvim-hlslens',
    config = config.hlslens
  }

  use { 'norcalli/nvim-colorizer.lua',
    config = config.colorizer
  }

  use { 'winston0410/cmd-parser.nvim' }

  use { 'winston0410/range-highlight.nvim',
    config = config.range_highlight
  }

  use { 'folke/twilight.nvim' }

  use { 'rockerBOO/boo-colorscheme-nvim' }

  use { 'folke/tokyonight.nvim' }

  use { 'navarasu/onedark.nvim' }

  use { 'goolord/alpha-nvim',
    config = config.alpha
  }

end)

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
