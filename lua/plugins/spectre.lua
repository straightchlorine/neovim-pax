-- nvim-spectre
-- https://github.com/nvim-pack/nvim-spectre

return {
  "nvim-pack/nvim-spectre",
  build = false,
  cmd = "Spectre",
  opts = { open_cmd = "noswapfile vnew" },
  keys = {
    {
      "<leader>sr",
      function()
        require("spectre").toggle()
      end,
      desc = "spectre: replace in files (spectre)",
    },
    {
      "<leader>sw",
      function()
        require("spectre").open_visual({ select_word = true })
      end,
      desc = "spectre: search current word",
    },
    {
      "<leader>sw",
      function()
        require("spectre").open_visual()
      end,
      mode = "v",
      desc = "spectre: search current word",
    },
    {
      "<leader>sp",
      function()
        require("spectre").open_file_search({ select_word = true })
      end,
      desc = "spectre: search on current file",
    },
  },
  config = function(_, opts)
    require("spectre").setup(opts)
  end,
}