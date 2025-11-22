-- possession.nvim
-- https://github.com/jedrzejboczar/possession.nvim

return {
  "jedrzejboczar/possession.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("possession").setup({
      session_dir = vim.fn.stdpath("data") .. "/possession/sessions",
      silent = false,
      load_silent = true,
      debug = false,
      logfile = false,
      prompt_no_cr = false,
      autosave = {
        current = true, -- autosave current session
        tmp = false,     -- autosave tmp session (last session before quit)
        tmp_name = "tmp",
        on_load = true,  -- autosave on session load
        on_quit = true,
      },
      commands = {
        save = "PossessionSave",
        load = "PossessionLoad",
        rename = "PossessionRename",
        close = "PossessionClose",
        delete = "PossessionDelete",
        show = "PossessionShow",
        list = "PossessionList",
        migrate = "PossessionMigrate",
      },
      hooks = {
        before_save = function(name) return {} end,
        after_save = function(name, user_data, aborted) end,
        before_load = function(name, user_data) return user_data end,
        after_load = function(name, user_data) end,
      },
      plugins = {
        close_windows = {
          hooks = {"before_save", "before_load"},
          preserve_layout = true,  -- don't delete empty windows
          match = {
            floating = true,
            buftype = {},
            filetype = {},
            custom = false,
          },
        },
        delete_hidden_buffers = {
          hooks = {
            "before_load",
            vim.o.sessionoptions:match("buffer") and "before_save",
          },
          force = false,
        },
        nvim_tree = false,
        neo_tree = false,
        symbols_outline = false,
        outline = false,
        tabby = false,
        dap = true,
        dapui = true,
        neotest = true,
        delete_buffers = false,
      },
    })

    -- Keybindings
    vim.keymap.set("n", "<leader>ws", "<cmd>PossessionSave<cr>", { desc = "possession: save session" })
    vim.keymap.set("n", "<leader>wl", "<cmd>PossessionLoad<cr>", { desc = "possession: load session" })
    vim.keymap.set("n", "<leader>wd", "<cmd>PossessionDelete<cr>", { desc = "possession: delete session" })
    vim.keymap.set("n", "<leader>wr", "<cmd>PossessionList<cr>", { desc = "possession: search sessions" })
  end,
}
