-- nvim-treesitter-textobjects
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects

return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "master", -- pin to master; main branch is an incompatible rewrite
  event = "VeryLazy",
  enabled = true,
  config = function()
    -- If treesitter is already loaded, we need to run config again for textobjects
    if vim.tbl_contains(vim.api.nvim_list_runtime_paths(), vim.fn.stdpath("data") .. "/lazy/nvim-treesitter") then
      local opts = require("nvim-treesitter.configs").get_module("textobjects")
      for name, module in pairs(opts or {}) do
        opts[name] = module
      end
    end

    require("nvim-treesitter.configs").setup({
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["ai"] = "@conditional.outer",
            ["ii"] = "@conditional.inner",
            ["a/"] = "@comment.outer",
            ["i/"] = "@comment.inner",
            ["ak"] = "@assignment.outer",
            ["ik"] = "@assignment.inner",
            ["a="] = "@assignment.lhs",
            ["i="] = "@assignment.rhs",
          },
          -- You can choose the select mode (default is charwise 'v')
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap` and `aw` textobjects.
          include_surrounding_whitespace = true,
        },
        move = {
          enable = true,
          -- whether to set jumps in the jumplist
          set_jumps = true, 
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
            ["]a"] = "@parameter.inner",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
            ["]A"] = "@parameter.inner",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[a"] = "@parameter.inner",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
            ["[A"] = "@parameter.inner",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            [">a"] = "@parameter.inner",
            [">f"] = "@function.outer",
          },
          swap_previous = {
            ["<a"] = "@parameter.inner",
            ["<f"] = "@function.outer",
          },
        },
      },
    })

    -- Repeat movement with ; and ,
    -- make sure ; goes forward and , goes backward regardless of the last direction
    local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

    -- Repeat movement with ; and ,
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

    -- vim way: ; goes to the direction you were moving.
    -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
    -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

    -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
  end,
}