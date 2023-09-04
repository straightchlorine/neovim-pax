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
    config = config.treesitter,
  }

  -- autocompletion plugins
  use { 'neovim/nvim-lspconfig' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'hrsh7th/ncim-cmp' }
  use { 'SirVer/ultiships' }
  use { 'quangnguyen30192/cmp-nvim-ultisnips' }

end)
