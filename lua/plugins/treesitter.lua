-- nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter

return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "HiPhish/rainbow-delimiters.nvim",
    {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup({
          pre_hook = function()
            return vim.bo.commentstring
          end,
        })
      end,
    },
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      autotag = { enable = true },

      auto_install = true,

      -- parsers
      ensure_installed = {
        "arduino",
        "asm",
        "bash",
        "bibtex",
        "c",
        "c_sharp",
        "cmake",
        "comment",
        "cpp",
        "css",
        "csv",
        "dart",
        "disassembly",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "haskell",
        "html",
        "java",
        "javascript",
        "json",
        "jq",
        "julia",
        "latex",
        "llvm",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "meson",
        "ninja",
        "psv",
        "python",
        "rasi",
        "regex",
        "rust",
        "scala",
        "sql",
        "tmux",
        "verilog",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "go",
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<C-s>",
          node_decremental = "<bs>",
        },
      },

      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["ai"] = "@conditional.outer",
            ["ii"] = "@conditional.inner",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
            ["as"] = "@statement.outer",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
      },
    })

    require("ts_context_commentstring").setup()
    vim.g.skip_ts_context_commentstring_module = true

    local rainbow_delimiters = require("rainbow-delimiters")
    vim.g.rainbow_delimiters = {
      strategy = {
        [""] = rainbow_delimiters.strategy["global"],
      },
      query = {
        [""] = "rainbow-delimiters",
      },
    }

    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt.foldenable = false
  end,
}
