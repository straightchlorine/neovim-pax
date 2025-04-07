-- mini.nvim
-- https://github.com/echasnovski/mini.nvim

return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.ai").setup()
    require("mini.bracketed").setup()
    require("mini.clue").setup()
    require("mini.comment").setup()
    require("mini.cursorword").setup()
    require("mini.trailspace").setup()
  end,
}
