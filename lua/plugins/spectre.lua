-- grug-far.nvim (replaces nvim-spectre)
-- https://github.com/MagicDuck/grug-far.nvim

return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  keys = {
    {
      "<leader>sr",
      function()
        require("grug-far").open()
      end,
      desc = "grug-far: search and replace",
    },
    {
      "<leader>sw",
      function()
        require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
      end,
      desc = "grug-far: search current word",
    },
    {
      "<leader>sw",
      function()
        require("grug-far").with_visual_selection()
      end,
      mode = "v",
      desc = "grug-far: search selection",
    },
    {
      "<leader>sf",
      function()
        require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
      end,
      desc = "grug-far: search in current file",
    },
  },
  opts = {},
}
