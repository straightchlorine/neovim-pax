-- telescope.nvim
-- https://github.com/nvim-telescope/telescope.nvim

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "nvim-tree/nvim-web-devicons",
    "folke/trouble.nvim",
    "folke/todo-comments.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local trouble = require("trouble.sources.telescope")

    telescope.setup({
      defaults = {
        prompt_prefix = "❯ ",
        selection_caret = "❯ ",
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        mappings = {
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-c>"] = actions.close,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<C-t>"] = trouble.open,
            ["<C-a>"] = trouble.add,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<Esc>"] = actions.close,
          },
          n = {
            ["<C-t>"] = trouble.open,
            ["q"] = actions.close,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          },
        },
        file_ignore_patterns = {
          "%.git/",
          "node_modules/",
          "%.cache",
          "%.DS_Store",
          "%.vscode",
          "__pycache__/",
          "target/",
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          follow = true,
        },
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        file_browser = {
          hijack_netrw = true,
          hidden = true,
        },
        ui_select = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
    telescope.load_extension("file_browser")
    telescope.load_extension("todo-comments")

    local keymap = vim.keymap

    -- file navigation
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope: find files" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "telescope: find recent files" })
    keymap.set("n", "<leader>fb", "<cmd>Telescope file_browser<cr>", { desc = "telescope: file browser" })

    -- grep
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "telescope: find string" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "telescope: string under cursor" })
    keymap.set(
      "n",
      "<leader>fw",
      "<cmd>Telescope current_buffer_fuzzy_find<cr>",
      { desc = "telescope: fuzzy find in buffer" }
    )

    -- git
    keymap.set("n", "<leader>tgc", "<cmd>Telescope git_commits<cr>", { desc = "telescope: git commits" })
    keymap.set("n", "<leader>tgb", "<cmd>Telescope git_branches<cr>", { desc = "telescope: git branches" })
    keymap.set("n", "<leader>tgs", "<cmd>Telescope git_status<cr>", { desc = "telescope: git status" })

    -- nvim
    keymap.set("n", "<leader>km", "<cmd>Telescope keymaps<cr>", { desc = "telescope: keymaps" })
    keymap.set("n", "<leader>ct", "<cmd>Telescope colorscheme<cr>", { desc = "telescope: colorschemes" })
    keymap.set("n", "<leader>cm", "<cmd>Telescope commands<cr>", { desc = "telescope: commands" })
    keymap.set("n", "<leader>hl", "<cmd>Telescope highlights<cr>", { desc = "telescope: highlights" })
    keymap.set("n", "<leader>bf", "<cmd>Telescope buffers<cr>", { desc = "telescope: buffers" })

    -- todo comments
    keymap.set("n", "<leader>td", "<cmd>TodoTelescope<cr>", { desc = "telescope: todo comments" })
  end,
}
