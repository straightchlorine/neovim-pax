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
    
    -- Color highlighting (replaces colorizer.nvim)
    require("mini.hipatterns").setup({
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
        todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
        note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

        -- Highlight hex color strings (`#rrggbb`) with that color
        hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
      },
    })
    
    -- File management (modern marks replacement)
    require("mini.files").setup({
      content = {
        filter = nil,
        prefix = nil,
        sort = nil,
      },
      mappings = {
        close       = 'q',
        go_in       = 'l',
        go_in_plus  = 'L',
        go_out      = 'h',
        go_out_plus = 'H',
        mark_goto   = "'",
        mark_set    = 'm',
        reset       = '<BS>',
        reveal_cwd  = '@',
        show_help   = 'g?',
        synchronize = '=',
        trim_left   = '<',
        trim_right  = '>',
      },
      options = {
        permanent_delete = true,
        use_as_default_explorer = false,
      },
      windows = {
        max_number = math.huge,
        preview = false,
        width_focus = 50,
        width_nofocus = 15,
        width_preview = 25,
      },
    })

    -- Keybinding for mini.files (alternative to oil.nvim for some operations)
    vim.keymap.set("n", "<leader>mf", function() require("mini.files").open() end, { desc = "mini: open file manager" })
  end,
}
