-- nvim-treesitter-textobjects

return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  event = "VeryLazy",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
        selection_modes = {
          ["@parameter.outer"] = "v",
          ["@function.outer"] = "V",
          ["@class.outer"] = "<c-v>",
        },
        include_surrounding_whitespace = true,
      },
      move = { set_jumps = true },
    })

    local select = require("nvim-treesitter-textobjects.select")
    local move = require("nvim-treesitter-textobjects.move")
    local swap = require("nvim-treesitter-textobjects.swap")
    local rep = require("nvim-treesitter-textobjects.repeatable_move")

    local selects = {
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
      ["as"] = "@statement.outer",
    }
    for keys, capture in pairs(selects) do
      vim.keymap.set({ "x", "o" }, keys, function()
        select.select_textobject(capture, "textobjects")
      end, { desc = "select " .. capture })
    end

    local moves = {
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]f"] = "@function.outer",
        ["]]"] = "@class.outer",
        ["]c"] = "@class.outer",
        ["]a"] = "@parameter.inner",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]F"] = "@function.outer",
        ["]["] = "@class.outer",
        ["]C"] = "@class.outer",
        ["]A"] = "@parameter.inner",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[f"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[c"] = "@class.outer",
        ["[a"] = "@parameter.inner",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[F"] = "@function.outer",
        ["[]"] = "@class.outer",
        ["[C"] = "@class.outer",
        ["[A"] = "@parameter.inner",
      },
    }
    for dir, keymaps in pairs(moves) do
      for keys, capture in pairs(keymaps) do
        local fn = rep.make_repeatable_move(function()
          move[dir](capture, "textobjects")
        end)
        vim.keymap.set({ "n", "x", "o" }, keys, fn, { desc = dir .. " " .. capture })
      end
    end

    vim.keymap.set("n", "<leader>a", function()
      swap.swap_next("@parameter.inner")
    end, { desc = "swap next parameter" })
    vim.keymap.set("n", "<leader>A", function()
      swap.swap_previous("@parameter.inner")
    end, { desc = "swap prev parameter" })
    vim.keymap.set("n", ">a", function()
      swap.swap_next("@parameter.inner")
    end, { desc = "swap next parameter" })
    vim.keymap.set("n", "<a", function()
      swap.swap_previous("@parameter.inner")
    end, { desc = "swap prev parameter" })
    vim.keymap.set("n", ">f", function()
      swap.swap_next("@function.outer")
    end, { desc = "swap next function" })
    vim.keymap.set("n", "<f", function()
      swap.swap_previous("@function.outer")
    end, { desc = "swap prev function" })

    vim.keymap.set({ "n", "x", "o" }, ";", rep.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, ",", rep.repeat_last_move_previous)
    vim.keymap.set({ "n", "x", "o" }, "f", rep.builtin_f_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "F", rep.builtin_F_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "t", rep.builtin_t_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "T", rep.builtin_T_expr, { expr = true })
  end,
}
