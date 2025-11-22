-- mini.nvim
-- https://github.com/echasnovski/mini.nvim

return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.ai").setup()
    require("mini.bracketed").setup()
    require("mini.clue").setup()

    -- Treesitter-aware commenting
    require("mini.comment").setup({
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    })

    require("mini.cursorword").setup()
    require("mini.trailspace").setup()
    require("mini.pairs").setup()

    require("mini.statusline").setup({
      use_icons = true,
      set_vim_settings = true,
      content = {
        active = function()
          local mode, mode_hl = require("mini.statusline").section_mode({ trunc_width = 120 })
          local git = require("mini.statusline").section_git({ trunc_width = 75 })
          local diagnostics = require("mini.statusline").section_diagnostics({ trunc_width = 75 })
          local filename = require("mini.statusline").section_filename({ trunc_width = 140 })
          local fileinfo = require("mini.statusline").section_fileinfo({ trunc_width = 120 })
          local location = require("mini.statusline").section_location({ trunc_width = 75 })
          local search = require("mini.statusline").section_searchcount({ trunc_width = 75 })

          return require("mini.statusline").combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
            "%<", -- Mark general truncate point
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=", -- End left alignment
            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            { hl = mode_hl, strings = { search, location } },
          })
        end,
      },
    })

    require("mini.hipatterns").setup({
      highlighters = {
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
        todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
        note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },
        hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
      },
    })
  end,
}
