-- neo-tree.nvim
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      local events = require("neo-tree.events")
      require("neo-tree").setup({
        -- attach your FILE_MOVED / FILE_RENAMED handlers:
        event_handlers = {
          {
            event = events.FILE_MOVED,
            handler = function(data)
              Snacks.rename.on_rename_file(data.source, data.destination)
            end,
          },
          {
            event = events.FILE_RENAMED,
            handler = function(data)
              Snacks.rename.on_rename_file(data.source, data.destination)
            end,
          },
        },

        filesystem = {
          -- define your custom Avante command under the filesystem source:
          commands = {
            avante_add_files = function(state)
              local node = state.tree:get_node()
              local filepath = node:get_id()
              local rel_path = require("avante.utils").relative_path(filepath)

              -- ensure Avante sidebar is open
              local sidebar = require("avante").get()
              if not sidebar:is_open() then
                require("avante.api").ask()
                sidebar = require("avante").get()
              end

              -- add & then clean up the placeholder Neo-Tree buffer
              sidebar.file_selector:add_selected_file(rel_path)
              if not sidebar:is_open() then
                sidebar.file_selector:remove_selected_file("neo-tree filesystem [1]")
              end
            end,
          },

          window = {
            mappings = {
              -- bind the Avante command:
              ["oa"] = "avante_add_files",
              -- your other preview mappings:
              ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
              ["l"] = "focus_preview",
              ["<C-b>"] = { "scroll_preview", config = { direction = 10 } },
              ["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
            },
          },
        },

        -- (you can also configure other sources here: buffers, git_status, etc.)
      })

      -- global Neotree toggle:
      vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "neotree: toggle" })
    end,
  },
}
