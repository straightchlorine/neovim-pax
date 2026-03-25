-- grug-far.nvim (replaces nvim-spectre)
-- https://github.com/MagicDuck/grug-far.nvim

return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  keys = {
    {
      "<leader>rr",
      function()
        require("grug-far").open()
      end,
      desc = "grug-far: search and replace",
    },
    {
      "<leader>rw",
      function()
        require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
      end,
      desc = "grug-far: replace current word",
    },
    {
      "<leader>rw",
      function()
        require("grug-far").with_visual_selection()
      end,
      mode = "v",
      desc = "grug-far: replace selection",
    },
    {
      "<leader>rf",
      function()
        require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
      end,
      desc = "grug-far: replace in current file",
    },
  },
  opts = {},
}
