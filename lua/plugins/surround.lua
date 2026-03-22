-- nvim-surround
-- https://github.com/kylechui/nvim-surround

return {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      surrounds = {
        ["```"] = {
          add = function()
            local lang = vim.fn.input("Language: ")
            return { { "```" .. lang }, { "```" } }
          end,
        },
      },
      highlight = {
        duration = 500,
      },
      move_cursor = "begin",
    })
  end,
}
