local config = require('configuration')

return require('packer').startup(function (use)
  use { 'wbthomason/packer.nvim'}

  use { 'nvim-lua/plenary.nvim' }

  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = config.treesitter,
  }
end)
