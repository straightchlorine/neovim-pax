-- nvim-surround
-- https://github.com/kylechui/nvim-surround

return {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "S",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
      },
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
